part of 'verify_otp_bloc.dart';

@freezed
abstract class VerifyOtpEvent with _$VerifyOtpEvent {
  const factory VerifyOtpEvent.verifyOTP({
    required String email,
    required String otp,
  }) = _VerifyOTP;
}
