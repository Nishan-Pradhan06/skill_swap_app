part of 'profile_setup_bloc.dart';

@freezed
abstract class ProfileSetupEvent with _$ProfileSetupEvent {
  const factory ProfileSetupEvent.userProfileSetUp(UserProfileSetUpModel userProfileSetUp) = _UserProfileSetupE;
}