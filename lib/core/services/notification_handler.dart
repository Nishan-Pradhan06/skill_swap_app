import 'dart:developer';
import 'package:go_router/go_router.dart';

/// Centralized notification handler for navigation
/// Handles different notification types and navigates to appropriate screens
class NotificationHandler {
  /// Handle notification tap and navigate to appropriate screen
  static void handleNotificationTap(
    Map<String, dynamic> data,
    GoRouter router,
  ) {
    if (data.isEmpty) {
      log('No data in notification');
      return;
    }

    final notificationType = data['type'] as String?;
    final screen = data['screen'] as String?;
    final sessionId = data['session_id'] as String?;

    log(
      'Handling notification: type=$notificationType, screen=$screen, sessionId=$sessionId',
    );

    // Navigate based on screen parameter
    switch (screen) {
      case 'my_learning':
        router.go('/learner/my-learning');
        break;
      case 'mentor_sessions':
        router.go('/mentor/sessions');
        break;
      case 'home':
        router.go('/home');
        break;
      default:
        log('Unknown screen: $screen');
        // Default to home if screen is not recognized
        router.go('/home');
    }
  }

  /// Get notification priority based on type
  static String getNotificationPriority(String? type) {
    switch (type) {
      case 'session_request':
      case 'session_accepted':
      case 'session_rejected':
        return 'high';
      case 'session_completed':
      case 'swap_request_accepted':
      case 'swap_request_rejected':
        return 'default';
      default:
        return 'default';
    }
  }

  /// Get notification channel based on type
  static String getNotificationChannel(String? type) {
    switch (type) {
      case 'session_request':
      case 'session_accepted':
      case 'session_rejected':
      case 'session_completed':
        return 'sessions';
      case 'swap_request_accepted':
      case 'swap_request_rejected':
      case 'swap_completed':
        return 'swap_requests';
      case 'points_received':
        return 'points';
      default:
        return 'general';
    }
  }
}
