import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/notifications/repository/notification_repository.dart';

part 'delete_notification_event.dart';
part 'delete_notification_state.dart';
part 'delete_notification_bloc.freezed.dart';

class DeleteNotificationBloc
    extends Bloc<DeleteNotificationEvent, DeleteNotificationState> {
  final NotificationRepository _notificationRepository;
  DeleteNotificationBloc({required NotificationRepository repo})
    : _notificationRepository = repo,
      super(DeleteNotificationState.initial()) {
    on<_DeleteNotificationE>(_onDeleteNotifications);
  }
  Future<void> _onDeleteNotifications(
    _DeleteNotificationE event,
    Emitter<DeleteNotificationState> emit,
  ) async {
    emit(DeleteNotificationState.loading());

    final result = await _notificationRepository.deleteNotification(
      notificationId: event.notificationId,
    );

    result.fold(
      (failure) => emit(DeleteNotificationState.failure(failure)),
      (data) => emit(DeleteNotificationState.loaded(data)),
    );
  }
}
