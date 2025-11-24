
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:skill_swap/core/theme/app_theme.dart';

class Notification {
  final int id;
  final String title;
  final String message;
  bool isRead;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      isRead: json['is_read'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Notification> notifications = [];

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  void loadNotifications() {
    const jsonData = '''
    {
      "notifications": [
        {
          "id": 1,
          "title": "Welcome Reward",
          "message": "You received 100 points for registering!",
          "is_read": false,
          "created_at": "2025-11-24T04:42:15.816036Z"
        },
        {
          "id": 2,
          "title": "New Achievement",
          "message": "Congratulations! You've unlocked the 'Early Bird' badge.",
          "is_read": false,
          "created_at": "2025-11-23T10:30:00.000000Z"
        },
        {
          "id": 3,
          "title": "System Update",
          "message": "We've updated our app with new features and improvements.",
          "is_read": true,
          "created_at": "2025-11-22T08:15:00.000000Z"
        }
      ]
    }
    ''';

    final data = json.decode(jsonData);
    setState(() {
      notifications = (data['notifications'] as List)
          .map((item) => Notification.fromJson(item))
          .toList();
    });
  }

  void markAsRead(int id) {
    setState(() {
      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index].isRead = true;
      }
    });
  }

  void markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });
  }

  void deleteNotification(int id) {
    setState(() {
      notifications.removeWhere((n) => n.id == id);
    });
  }

  String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined, size: 80),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Dismissible(
                  key: Key(notification.id.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    deleteNotification(notification.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Notification deleted')),
                    );
                  },
                  child: NotificationCard(
                    notification: notification,
                    timeAgo: getTimeAgo(notification.createdAt),
                    onTap: () => markAsRead(notification.id),
                  ),
                );
              },
            ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final Notification notification;
  final String timeAgo;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.timeAgo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: notification.isRead
              ? ColorScheme.of(context).background
              : Colors.red.withValues(alpha: 0.1),
          border: Border(
            bottom: BorderSide(color: AppTheme.dividerDark, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: notification.isRead
                      ? Colors.grey[200]
                      : ColorScheme.of(context).primary.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications,
                  color: notification.isRead
                      ? Colors.grey[600]
                      : ColorScheme.of(context).surface,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: notification.isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: ColorScheme.of(context).primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      timeAgo,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
