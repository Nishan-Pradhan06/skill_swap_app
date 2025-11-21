import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/auth/models/sign_in_model.dart';
import 'package:skill_swap/features/auth/repository/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _authRepository;
  SignInBloc({required AuthRepository repo})
    : _authRepository = repo,
      super(SignInState.initial()) {
    on<_SignInE>(_onSignIn);
  }

  Future<void> _onSignIn(_SignInE event, Emitter<SignInState> emit) async {
    emit(SignInState.loading());

    final result = await _authRepository.signIn(signInModel: event.signInModel);

    result.fold(
      (failure) => emit(SignInState.failure(failure)),
      (data) => emit(SignInState.loaded(data)),
    );
  }
}
