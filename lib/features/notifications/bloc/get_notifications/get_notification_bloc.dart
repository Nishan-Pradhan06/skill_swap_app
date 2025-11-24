import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/notifications/repository/notification_repository.dart';

import '../../models/notifications_model.dart';

part 'get_notification_event.dart';
part 'get_notification_state.dart';
part 'get_notification_bloc.freezed.dart';

class GetNotificationBloc
    extends Bloc<GetNotificationEvent, GetNotificationState> {
  final NotificationRepository _notificationRepository;
  GetNotificationBloc({required NotificationRepository repo})
    : _notificationRepository = repo,
      super(GetNotificationState.initial()) {
    on<_GetNotificationE>(_onGetNotifications);
  }

  Future<void> _onGetNotifications(
    _GetNotificationE event,
    Emitter<GetNotificationState> emit,
  ) async {
    emit(GetNotificationState.loading());

    final result = await _notificationRepository.getNotification();

    result.fold(
      (failure) => emit(GetNotificationState.failure(failure)),
      (data) => emit(GetNotificationState.loaded(data)),
    );
  }
}
