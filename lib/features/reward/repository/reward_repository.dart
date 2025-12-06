import 'package:dartz/dartz.dart';
import 'package:skill_swap/common/typedef/either_type.dart';
import 'package:skill_swap/core/network/api_services.dart';

abstract interface class RewardRepository {
  FutureEither<String> dailyReward();
}

class RewardRepositoryImpl implements RewardRepository {
  final ApiService _apiService;
  RewardRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<String> dailyReward() async {
    final response = await _apiService.post('reward/daily-reward/');

    return response.fold((failure) => Left(failure), (data) {
      return Right(data['message']);
    });
  }
}
