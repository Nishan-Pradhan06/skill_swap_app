part of 'sign_in_bloc.dart';

@freezed
abstract class SignInEvent with _$SignInEvent {
  const factory SignInEvent.signIn({required SignInModel signInModel}) = _SignInE;
}