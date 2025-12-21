import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/utils/time_ago_utils.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/notifications/bloc/delete_notifications/delete_notification_bloc.dart';

import 'package:skill_swap/features/notifications/bloc/get_notifications/get_notification_bloc.dart';
import 'package:skill_swap/features/notifications/bloc/read_notifications/read_notifications_bloc.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/custom_scrollable_padding.dart';
import '../bloc/get_notification_count/get_notification_count_bloc.dart';
import '../models/notifications_model.dart';
import '../widgets/notification_card_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      body: BlocBuilder<GetNotificationBloc, GetNotificationState>(
        builder: (context, state) {
          return state.when(
            initial: () => _buildSkeletonUI(context, isLoading: true),
            loading: () => _buildSkeletonUI(context, isLoading: true),
            failure: (failure) => Center(
              child: Text(
                'Error: ${failure.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ),

            loaded: (data) {
              if (data.isEmpty) {
                // Show empty state
                return ScrollableRefreshablePadding(
                  onRefresh: () async {
                    sl<GetNotificationBloc>().add(
                      GetNotificationEvent.getNotification(),
                    );
                    sl<GetNotificationCountBloc>().add(
                      GetNotificationCountEvent.getNotificationCount(),
                    );
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off_outlined, size: 80),
                        const SizedBox(height: 16),
                        Text(
                          'No notifications',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Non-empty state
              return RefreshIndicator(
                onRefresh: () async {
                  sl<GetNotificationBloc>().add(
                    GetNotificationEvent.getNotification(),
                  );
                },
                child:
                    BlocConsumer<
                      DeleteNotificationBloc,
                      DeleteNotificationState
                    >(
                      listener: (context, state) {
                        state.whenOrNull(
                          failure: (failure) {
                            CustomToast.showError(failure.message);
                          },
                          loaded: (data) {
                            CustomToast.showSuccess(data);
                          },
                        );
                      },
                      builder: (context, state) {
                        return ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final notification = data[index];
                            return Dismissible(
                              key: Key(notification.id.toString()),
                              background: Container(
                                color: ColorScheme.of(context).primary,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                final id = notification.id;

                                // remove item LOCALLY
                                data.removeAt(index);

                                // update UI
                                (context as Element).markNeedsBuild();

                                // call API
                                sl<DeleteNotificationBloc>().add(
                                  DeleteNotificationEvent.deleteNotification(
                                    notificationId: id,
                                  ),
                                );
                              },
                              child: _buildNotificationContent(
                                context,
                                data[index],
                                isLoading: false,
                              ),
                            );
                          },
                        );
                      },
                    ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSkeletonUI(BuildContext context, {required bool isLoading}) {
    return ScrollableRefreshablePadding(
      onRefresh: () async {
        sl<GetNotificationBloc>().add(GetNotificationEvent.getNotification());
      },
      child: Skeletonizer(
        enabled: isLoading,
        child: _buildNotificationContent(context, null, isLoading: isLoading),
      ),
    );
  }

  Widget _buildNotificationContent(
    BuildContext context,

    NotificationModel? data, {
    required bool isLoading,
  }) {
    final timeAgo = data?.createdAt != null
        ? TimeAgo.format(data!.createdAt)
        : "N/A";
    return BlocConsumer<ReadNotificationsBloc, ReadNotificationsState>(
      listener: (context, state) {
        state.whenOrNull(
          failure: (failure) {
            CustomToast.showError(failure.message);
          },
          loaded: (data) {
            sl<GetNotificationBloc>().add(
              GetNotificationEvent.getNotification(),
            );
            sl<GetNotificationCountBloc>().add(
              GetNotificationCountEvent.getNotificationCount(),
            );
            CustomToast.showSuccess(data);
          },
        );
      },
      builder: (context, state) {
        final nId = data?.id ?? 0;
        return NotificationCard(
          title: data?.title.toString() ?? '',
          message: data?.message ?? '',
          isRead: data?.isRead ?? false,
          createdAt: timeAgo.toString(),
          onTap: data?.isRead == true
              ? () {}
              : () {
                  sl<ReadNotificationsBloc>().add(
                    ReadNotificationsEvent.readNotifications(
                      notificationId: nId,
                    ),
                  );
                },
        );
      },
    );
  }
}
