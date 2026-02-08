import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/auth/repository/auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';
part 'forgot_password_bloc.freezed.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository _repository;

  ForgotPasswordBloc({required AuthRepository repository})
    : _repository = repository,
      super(const ForgotPasswordState.initial()) {
    on<_Submit>(_onSubmit);
  }

  Future<void> _onSubmit(
    _Submit event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(const ForgotPasswordState.loading());
    final result = await _repository.forgotPassword(email: event.email);
    result.fold(
      (failure) => emit(ForgotPasswordState.failure(failure)),
      (message) => emit(ForgotPasswordState.loaded(message)),
    );
  }
}
