import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:skill_swap/features/profile/model/profile_model.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';
import '../model/profile_setup_model.dart';

abstract interface class ProfileRepository {
  FutureEither<ProfileDataModel> getProfile();
  FutureEither<String> setUpProfile({
    required UserProfileSetUpModel profileSetUpModel,
  });
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService _apiService;

  ProfileRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;
  @override
  FutureEither<ProfileDataModel> getProfile() async {
    final response = await _apiService.get('profile/me/');

    return response.fold((failure) => Left(failure), (data) {
      final profileData = data;
      final profileModel = ProfileDataModel.fromMap(profileData);
      return Right(profileModel);
    });
  }

  @override
  FutureEither<String> setUpProfile({
    required UserProfileSetUpModel profileSetUpModel,
  }) async {
    FormData formData = FormData.fromMap({
      ...profileSetUpModel.toMap(),
      'profile_image': profileSetUpModel.profileImage == null
          ? null
          : await MultipartFile.fromFile(
              profileSetUpModel.profileImage!.path,
              filename: profileSetUpModel.profileImage!.path.split('/').last,
            ),
    });
    final response = await _apiService.post<Map>(
      'profile/setup/',
      data: formData,
    );

    return response.fold((failure) => Left(failure), (data) async {
      return Right(data['message']);
    });
  }
}
