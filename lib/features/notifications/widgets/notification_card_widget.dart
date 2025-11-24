import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class NotificationCard extends StatelessWidget {
  // final NotificationModel notification;
  final String title;
  final String message;
  final String createdAt;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isRead
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
                  color: isRead
                      ? Colors.grey[200]
                      : ColorScheme.of(context).primary.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications,
                  color: isRead
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
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                        ),
                        if (!isRead)
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
                      message,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      createdAt,
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
