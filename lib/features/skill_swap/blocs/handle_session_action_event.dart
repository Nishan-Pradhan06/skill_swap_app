part of 'handle_session_action_bloc.dart';

@freezed
abstract class HandleSessionActionEvent with _$HandleSessionActionEvent {
  const factory HandleSessionActionEvent.performAction({
    required int sessionId,
    required String action,
  }) = _PerformAction;
}
