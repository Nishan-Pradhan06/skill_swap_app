import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/utils/time_ago_utils.dart';

import 'package:skill_swap/features/notifications/bloc/get_notifications/get_notification_bloc.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/custom_scrollable_padding.dart';
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
                child: ListView.builder(
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
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // deleteNotification(notification.id);
                      },
                      child: _buildNotificationContent(
                        context,
                        data[index],
                        isLoading: false,
                      ),
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
    return NotificationCard(
      title: data?.title.toString() ?? '',
      message: data?.message ?? '',
      isRead: data?.isRead ?? false,
      createdAt: timeAgo.toString(),
      onTap: () {},
    );
  }
}
