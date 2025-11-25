part of 'read_notifications_bloc.dart';

@freezed
abstract class ReadNotificationsEvent with _$ReadNotificationsEvent {
  const factory ReadNotificationsEvent.readNotifications({required int notificationId}) = _ReadNotificationE;
}