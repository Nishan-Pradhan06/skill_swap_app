import 'package:dartz/dartz.dart';
import 'package:skill_swap/common/typedef/either_type.dart';
import 'package:skill_swap/core/network/api_services.dart';

import '../../../core/services/cache_service.dart';
import '../models/sign_in_model.dart';
import '../models/sign_up_model.dart';

abstract interface class AuthRepository {
  FutureEither<String> signIn({required SignInModel signInModel});
  FutureEither<String> signUp({required SignUpModel signUpModel});
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
      final token = data['token']['access'];
      await CacheServices.instance.setAuthToken(token);
      return Right(token);
    });
  }

  @override
  FutureEither<String> signUp({required SignUpModel signUpModel}) async {
    final response = await _apiService.post<Map>(
      'auth/signup/',
      data: {...signUpModel.toMap()},
    );

    return response.fold((failure) => Left(failure), (data) async {
      final token = data['token']['access'];
      await CacheServices.instance.setAuthToken(token);
      return Right(token);
    });
  }
}
