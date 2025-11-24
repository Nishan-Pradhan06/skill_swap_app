// import 'package:flutter/material.dart';

// import 'package:skill_swap/core/theme/app_theme.dart';

// import '../models/notifications_model.dart';
// import '../widgets/notification_card_widget.dart';


import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({super.key});

//   @override
//   State<NotificationsPage> createState() => _NotificationsPageState();
// }

// class _NotificationsPageState extends State<NotificationsPage> {
//   void markAsRead(int id) {
//     setState(() {
//       final index = notifications.indexWhere((n) => n.id == id);
//       if (index != -1) {
//         notifications[index].isRead = true;
//       }
//     });
//   }

//   void markAllAsRead() {
//     setState(() {
//       for (var notification in notifications) {
//         notification.isRead = true;
//       }
//     });
//   }

//   void deleteNotification(int id) {
//     setState(() {
//       notifications.removeWhere((n) => n.id == id);
//     });
//   }

//   String getTimeAgo(DateTime dateTime) {
//     final now = DateTime.now();
//     final difference = now.difference(dateTime);

//     if (difference.inDays > 0) {
//       return '${difference.inDays}d ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours}h ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes}m ago';
//     } else {
//       return 'Just now';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notifications'),
//         scrolledUnderElevation: 0,
//         centerTitle: false,
//       ),
//       body: notifications.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.notifications_off_outlined, size: 80),
//                   const SizedBox(height: 16),
//                   Text(
//                     'No notifications',
//                     style: TextStyle(fontSize: 18, color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//             )
//           : ListView.builder(
//               itemCount: 2,
//               itemBuilder: (context, index) {
//                 final notification = notifications[index];
//                 return Dismissible(
//                   key: Key(notification.id.toString()),
//                   background: Container(
//                     color: ColorScheme.of(context).primary,
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.only(right: 20),
//                     child: const Icon(Icons.delete, color: Colors.white),
//                   ),
//                   direction: DismissDirection.endToStart,
//                   onDismissed: (direction) {
//                     deleteNotification(notification.id);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Notification deleted')),
//                     );
//                   },
//                   child: NotificationCard(
//                     notification: notification,
//                     timeAgo: getTimeAgo(notification.createdAt),
//                     onTap: () => markAsRead(notification.id),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
