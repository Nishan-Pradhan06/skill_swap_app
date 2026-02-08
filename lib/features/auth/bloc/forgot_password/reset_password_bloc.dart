import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/auth/repository/auth_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';
part 'reset_password_bloc.freezed.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthRepository _repository;

  ResetPasswordBloc({required AuthRepository repository})
    : _repository = repository,
      super(const ResetPasswordState.initial()) {
    on<_Reset>(_onReset);
  }

  Future<void> _onReset(_Reset event, Emitter<ResetPasswordState> emit) async {
    emit(const ResetPasswordState.loading());
    final result = await _repository.resetPassword(
      email: event.email,
      code: event.code,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    );
    result.fold(
      (failure) => emit(ResetPasswordState.failure(failure)),
      (message) => emit(ResetPasswordState.loaded(message)),
    );
  }
}
