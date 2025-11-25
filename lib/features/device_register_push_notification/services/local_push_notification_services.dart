import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final AndroidNotificationChannel _defaultChannel =
      AndroidNotificationChannel(
        'default_channel_id',
        'General Notifications',
        description: 'Used for general app notifications.',
        importance: Importance.high,
        playSound: true,
      );

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(android: androidSettings);
    await _localNotificationsPlugin.initialize(settings);

    final androidImplementation = _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImplementation != null) {
      await androidImplementation.createNotificationChannel(_defaultChannel);
    }
  }

  void showNotification(RemoteMessage message) {
    final notification = message.notification;
    final android = notification?.android;

    if (notification == null || android == null) return;

    final AndroidNotificationDetails androidDetails;

    androidDetails = AndroidNotificationDetails(
      _defaultChannel.id,
      _defaultChannel.name,
      channelDescription: _defaultChannel.description,
      importance: Importance.high,
      priority: Priority.high,
      sound: _defaultChannel.sound,
      playSound: true,
    );

    final details = NotificationDetails(android: androidDetails);

    _localNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
    );
  }
}
