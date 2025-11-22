import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/auth/repository/auth_repository.dart';

import '../../models/sign_up_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
part 'sign_up_bloc.freezed.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;
  SignUpBloc({required AuthRepository repo})
    : _authRepository = repo,
      super(SignUpState.initial()) {
    on<_SignUpE>(_onSignUp);
  }

  Future<void> _onSignUp(_SignUpE event, Emitter<SignUpState> emit) async {
    emit(SignUpState.loading());

    final result = await _authRepository.signUp(signUpModel: event.signUpModel);

    result.fold(
      (failure) => emit(SignUpState.failure(failure)),
      (data) => emit(SignUpState.loaded(data)),
    );
  }
}
