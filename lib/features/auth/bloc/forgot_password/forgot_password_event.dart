part of 'forgot_password_bloc.dart';

@freezed
abstract class ForgotPasswordEvent with _$ForgotPasswordEvent {
  const factory ForgotPasswordEvent.submit(String email) = _Submit;
}
