import 'package:dartz/dartz.dart';
import 'package:skill_swap/common/logger.dart';
import 'package:skill_swap/common/typedef/either_type.dart';
import 'package:skill_swap/core/network/api_services.dart';

import '../../../core/services/cache_service.dart';
import '../models/sign_in_model.dart';
import '../models/sign_up_model.dart';

abstract interface class AuthRepository {
  FutureEither<String> signIn({required SignInModel signInModel});
  FutureEither<String> signUp({required SignUpModel signUpModel});
  FutureEither<String> signOut();
  FutureEither<String> forgotPassword({required String email});
  FutureEither<String> verifyCode({
    required String email,
    required String code,
  });
  FutureEither<String> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;

  AuthRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;
  @override
  FutureEither<String> signIn({required SignInModel signInModel}) async {
    final response = await _apiService.post<Map>(
      'auth/login/',
      data: {...signInModel.toMap()},
    );

    return response.fold((failure) => Left(failure), (data) async {
      final authData = data['data'];
      final token = authData['token']['access'];
      final role = (authData['user']['roles'] as List).first;
      dLog.d(token);
      dLog.d(role);
      await CacheServices.instance.setAuthToken(token);
      await CacheServices.instance.setUserRole(role);
      return Right(role);
    });
  }

  @override
  FutureEither<String> signUp({required SignUpModel signUpModel}) async {
    final response = await _apiService.post<Map>(
      'auth/signup/',
      data: {...signUpModel.toMap()},
    );

    return response.fold((failure) => Left(failure), (data) async {
      final authData = data['data'];
      final token = authData['token']['access'];
      await CacheServices.instance.setAuthToken(token);
      return Right("Sign up successful");
    });
  }

  @override
  FutureEither<String> signOut() async {
    await CacheServices.instance.clearAuthToken();

    return Right("Logout Successfully!!!");
  }

  @override
  FutureEither<String> forgotPassword({required String email}) async {
    final response = await _apiService.post<Map>(
      'auth/forgot-password/',
      data: {'email': email},
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data['message']),
    );
  }

  @override
  FutureEither<String> verifyCode({
    required String email,
    required String code,
  }) async {
    final response = await _apiService.post<Map>(
      'auth/verify-code/',
      data: {'email': email, 'code': code},
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data['message']),
    );
  }

  @override
  FutureEither<String> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await _apiService.post<Map>(
      'auth/reset-password/',
      data: {
        'email': email,
        'code': code,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      },
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data['message']),
    );
  }
}
