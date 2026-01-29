part of 'edit_profile_bloc.dart';

@freezed
abstract class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent.submit({
    required Map<String, dynamic> data,
    String? profileImagePath,
    String? bannerImagePath,
  }) = _Submit;
}
