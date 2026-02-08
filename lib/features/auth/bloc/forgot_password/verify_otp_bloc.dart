import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/auth/repository/auth_repository.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';
part 'verify_otp_bloc.freezed.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final AuthRepository _repository;

  VerifyOtpBloc({required AuthRepository repository})
    : _repository = repository,
      super(const VerifyOtpState.initial()) {
    on<_VerifyOTP>(_onVerifyOTP);
  }

  Future<void> _onVerifyOTP(
    _VerifyOTP event,
    Emitter<VerifyOtpState> emit,
  ) async {
    emit(const VerifyOtpState.loading());
    final result = await _repository.verifyCode(
      email: event.email,
      code: event.otp,
    );
    result.fold(
      (failure) => emit(VerifyOtpState.failure(failure)),
      (message) => emit(VerifyOtpState.loaded(message)),
    );
  }
}
