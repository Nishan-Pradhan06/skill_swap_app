part of 'get_public_profile_bloc.dart';

@freezed
abstract class GetPublicProfileEvent with _$GetPublicProfileEvent {
  const factory GetPublicProfileEvent.getProfile(int userId) = _GetProfile;
}
