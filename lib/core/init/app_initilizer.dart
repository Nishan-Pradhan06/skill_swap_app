import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../features/device_register_push_notification/services/push_notification_services.dart';
import '../config/env_config.dart';
import '../di/dependency_injection.dart';
import '../services/cache_service.dart';
import '../services/once_cache_service.dart';

class AppInitializer {
  static Future<void> init() async {
    // Load .env
    await dotenv.load(fileName: '.env');

    EnvConfig.initialize(Environment.development);

    log(EnvConfig.instance.apiBaseUrl);

    await setupServiceLocator();

    //Global SharedPreferences
    await CacheServices.instance.init();

    await sl<OnceCacheService>().init();

    //Firebase
    await Firebase.initializeApp();

    await PushNotificationService().init();
  }
}
