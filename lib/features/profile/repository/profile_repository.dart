import 'package:dartz/dartz.dart';
import 'package:skill_swap/features/profile/model/profile_model.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';

abstract interface class ProfileRepository {
  FutureEither<ProfileDataModel> getProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService _apiService;

  ProfileRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;
  @override
  FutureEither<ProfileDataModel> getProfile() async {
    final response = await _apiService.get('profile/me/');

    return response.fold((failure) => Left(failure), (data) {
      final profileData = data['data'];
      final profileModel = ProfileDataModel.fromMap(profileData);
      return Right(profileModel);
    });
  }
}
