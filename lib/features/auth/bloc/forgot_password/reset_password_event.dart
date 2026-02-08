part of 'reset_password_bloc.dart';

@freezed
abstract class ResetPasswordEvent with _$ResetPasswordEvent {
  const factory ResetPasswordEvent.reset({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) = _Reset;
}
