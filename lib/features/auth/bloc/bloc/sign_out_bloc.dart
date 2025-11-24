import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../repository/auth_repository.dart';

part 'sign_out_event.dart';
part 'sign_out_state.dart';
part 'sign_out_bloc.freezed.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  final AuthRepository _authRepository;
  SignOutBloc({required AuthRepository repo})
    : _authRepository = repo,
      super(SignOutState.initial()) {
    on<_SignOut>(_onSignOut);
  }

  Future<void> _onSignOut(_SignOut event, Emitter<SignOutState> emit) async {
    emit(SignOutState.loading());
    await Future.delayed(Duration(seconds: 3));

    final result = await _authRepository.signOut();

    result.fold(
      (failure) => emit(SignOutState.failure(failure)),
      (signOut) => emit(SignOutState.loaded(signOut)),
    );
  }
}
