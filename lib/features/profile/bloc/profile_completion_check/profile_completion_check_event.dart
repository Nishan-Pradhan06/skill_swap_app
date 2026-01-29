part of 'profile_completion_check_bloc.dart';

@freezed
class ProfileCompletionCheckEvent with _$ProfileCompletionCheckEvent {
  const factory ProfileCompletionCheckEvent.checkProfileCompletion() =
      _CheckProfileCompletion;
}
