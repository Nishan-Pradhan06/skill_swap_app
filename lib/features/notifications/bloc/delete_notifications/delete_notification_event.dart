part of 'delete_notification_bloc.dart';

@freezed
abstract class DeleteNotificationEvent with _$DeleteNotificationEvent {
  const factory DeleteNotificationEvent.deleteNotification({required int notificationId}) = _DeleteNotificationE;
}