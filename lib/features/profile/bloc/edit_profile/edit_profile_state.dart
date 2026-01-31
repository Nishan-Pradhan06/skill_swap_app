part of 'edit_profile_bloc.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.initial() = _Initial;
  const factory EditProfileState.loading() = _Loading;
  const factory EditProfileState.success(String message) = _Success;
  const factory EditProfileState.failure(String message) = _Failure;
}
