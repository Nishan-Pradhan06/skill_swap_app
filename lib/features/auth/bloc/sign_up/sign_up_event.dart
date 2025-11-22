part of 'sign_up_bloc.dart';

@freezed
abstract class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.signUp(SignUpModel signUpModel) = _SignUpE;
}