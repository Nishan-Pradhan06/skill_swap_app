import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/notifications/repository/notification_repository.dart';

part 'read_notifications_event.dart';
part 'read_notifications_state.dart';
part 'read_notifications_bloc.freezed.dart';

class ReadNotificationsBloc
    extends Bloc<ReadNotificationsEvent, ReadNotificationsState> {
  final NotificationRepository _notificationRepository;

  ReadNotificationsBloc({required NotificationRepository repo})
    : _notificationRepository = repo,
      super(ReadNotificationsState.initial()) {
    on<_ReadNotificationE>(_onReadNotifications);
  }

  Future<void> _onReadNotifications(
    _ReadNotificationE event,
    Emitter<ReadNotificationsState> emit,
  ) async {
    emit(ReadNotificationsState.loading());

    final result = await _notificationRepository.readNotification(
      notificationId: event.notificationId,
    );

    result.fold(
      (failure) => emit(ReadNotificationsState.failure(failure)),
      (data) => emit(ReadNotificationsState.loaded(data)),
    );
  }
}
