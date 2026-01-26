part of 'handle_session_action_bloc.dart';

@freezed
class HandleSessionActionState with _$HandleSessionActionState {
  const factory HandleSessionActionState.initial() = _Initial;
  const factory HandleSessionActionState.loading() = _Loading;
  const factory HandleSessionActionState.success(String message) = _Success;
  const factory HandleSessionActionState.failure(String message) = _Failure;
}
