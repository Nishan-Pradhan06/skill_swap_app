import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';

import '../repository/device_register_repository.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/services/notification_handler.dart';
import 'local_push_notification_services.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Background message received: ${message.notification?.title}');
}

class PushNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  GoRouter? _router;

  Future<void> init({GoRouter? router}) async {
    await Firebase.initializeApp();
    _router = router;

    await _requestPermission();
    await _setForegroundPresentationOptions();
    await initializeLocalNotification();
    listenMessage();
    _listenToTokenRefresh();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    log('Push Notification permission: ${settings.authorizationStatus}');
  }

  Future<void> _setForegroundPresentationOptions() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> initializeLocalNotification() async {
    await LocalNotificationService().initialize();
  }

  /// Listen for token refresh and update backend
  void _listenToTokenRefresh() {
    _messaging.onTokenRefresh.listen((newToken) async {
      log('FCM Token refreshed: ${newToken.substring(0, 20)}...');
      try {
        final repo = sl<DeviceRegisterForPushNotificationRepository>();
        await repo.deviceRegister();
        log('Updated token on backend');
      } catch (e) {
        log('Failed to update token on backend: $e');
      }
    });
  }

  void listenMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Foreground message received: ${message.notification?.title}');
      LocalNotificationService().showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Notification opened from background: ${message.data}');
      _handleNotificationNavigation(message.data);
    });

    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        log(
          'App opened from terminated state via notification: ${message.data}',
        );
        _handleNotificationNavigation(message.data);
      }
    });
  }

  void _handleNotificationNavigation(Map<String, dynamic> data) {
    if (data.isEmpty) {
      log('No data in notification');
      return;
    }

    if (_router != null) {
      NotificationHandler.handleNotificationTap(data, _router!);
    } else {
      log('Router not initialized, cannot navigate');
      // Store the navigation intent for later
      // You could use a state management solution here
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }
}
