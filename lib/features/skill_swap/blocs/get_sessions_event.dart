part of 'get_sessions_bloc.dart';

@freezed
abstract class GetSessionsEvent with _$GetSessionsEvent {
  const factory GetSessionsEvent.fetch({required String role}) = _Fetch;
}
