import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';

abstract interface class DeviceRegisterForPushNotificationRepository {
  FutureEither<String> deviceRegister();
}

class DeviceRegisterForPushNotificationRepositoryImpl
    implements DeviceRegisterForPushNotificationRepository {
  final ApiService _apiService;

  DeviceRegisterForPushNotificationRepositoryImpl({
    required ApiService apiService,
  }) : _apiService = apiService;

  @override
  FutureEither<String> deviceRegister() async {
    final FirebaseMessaging _messaging = FirebaseMessaging.instance;
    String? token;
    if (Platform.isIOS) {
      // token = await _messaging.getAPNSToken() ?? '';
    } else if (Platform.isAndroid) {
      token = await _messaging.getToken() ?? '';
      log('Android device token: $token');
    }

    final body = {
      'platform': Platform.isAndroid ? 'ANDROID' : 'IOS',
      'token': token,
    };

    final response = await _apiService.post<Map>('device/register', data: body);

    return response.fold((failure) => Left(failure), (data) {
      final deviceData = data['message'];

      return Right(deviceData);
    });
  }
}
