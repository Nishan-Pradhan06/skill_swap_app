part of 'get_sessions_bloc.dart';

@freezed
class GetSessionsState with _$GetSessionsState {
  const factory GetSessionsState.initial() = _Initial;
  const factory GetSessionsState.loading() = _Loading;
  const factory GetSessionsState.success(List<dynamic> sessions) = _Success;
  const factory GetSessionsState.failure(String message) = _Failure;
}
