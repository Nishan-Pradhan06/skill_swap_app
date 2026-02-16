import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_meeting_link_event.freezed.dart';

@freezed
abstract class UpdateMeetingLinkEvent with _$UpdateMeetingLinkEvent {
  const factory UpdateMeetingLinkEvent.update({
    required String skill,
    required String meetingLink,
  }) = _Update;
}
