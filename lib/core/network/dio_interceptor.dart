import 'dart:async';
import 'package:dio/dio.dart';
import '../../common/logger.dart';
import '../../router/app_routes_names.dart';
import '../services/cache_service.dart';
import '../services/navigation_service.dart';

class AppDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _attachTokenToRequest(options, handler);
  }

  Future<void> _attachTokenToRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = await CacheServices.getToken();
    options.headers['Authorization'] = 'Bearer $token';

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final String path = err.requestOptions.uri.path;
    dLog.d(
      "[Error] Interceptor caught an error for '/$path': ${err.response?.statusCode}",
    );

    if (err.response?.statusCode == 401) {
      NavigationService navigationService = NavigationService();
      navigationService.goNamed(AppRoutesName.authSignInScreenRoute);
    }
    return handler.next(err);
  }
}
