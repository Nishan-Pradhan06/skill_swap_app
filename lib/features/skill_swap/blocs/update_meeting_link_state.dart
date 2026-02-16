import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_meeting_link_state.freezed.dart';

@freezed
class UpdateMeetingLinkState with _$UpdateMeetingLinkState {
  const factory UpdateMeetingLinkState.initial() = _Initial;
  const factory UpdateMeetingLinkState.loading() = _Loading;
  const factory UpdateMeetingLinkState.success(String message) = _Success;
  const factory UpdateMeetingLinkState.failure(String message) = _Failure;
}
