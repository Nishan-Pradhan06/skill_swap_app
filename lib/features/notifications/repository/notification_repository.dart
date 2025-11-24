import 'package:dartz/dartz.dart';
import 'package:skill_swap/common/typedef/either_type.dart';
import 'package:skill_swap/core/network/api_services.dart';
import 'package:skill_swap/features/notifications/models/notifications_model.dart';

abstract interface class NotificationRepository {
  FutureEither<List<NotificationModel>> getNotification();
}

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiService _apiService;
  NotificationRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<List<NotificationModel>> getNotification() async {
    final response = await _apiService.get('notifications/');

    return response.fold((failure) => Left(failure), (data) {
      final List notificationsJson = data['notifications'] ?? [];

      final notifications = notificationsJson
          .map((json) => NotificationModel.fromJson(json))
          .toList();

      return Right(notifications);
    });
  }
}
