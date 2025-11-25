import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/notifications/repository/notification_repository.dart';

part 'get_notification_count_event.dart';
part 'get_notification_count_state.dart';
part 'get_notification_count_bloc.freezed.dart';

class GetNotificationCountBloc
    extends Bloc<GetNotificationCountEvent, GetNotificationCountState> {
  final NotificationRepository _notificationRepository;
  GetNotificationCountBloc({required NotificationRepository repo})
    : _notificationRepository = repo,
      super(GetNotificationCountState.initial()) {
    on<_GetNotificationCount>(_onGetNotificationCount);
  }

  Future<void> _onGetNotificationCount(
    _GetNotificationCount event,
    Emitter<GetNotificationCountState> emit,
  ) async {
    emit(GetNotificationCountState.loading());

    final result = await _notificationRepository.getNotificationCount();

    result.fold(
      (failure) => emit(GetNotificationCountState.failure(failure)),
      (data) => emit(GetNotificationCountState.loaded(data)),
    );
  }
}
