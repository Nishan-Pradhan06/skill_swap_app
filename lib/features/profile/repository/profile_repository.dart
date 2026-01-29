import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:skill_swap/features/profile/model/profile_model.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';
import '../model/profile_setup_model.dart';
import '../model/roles_model.dart';

import 'package:skill_swap/features/profile/model/profile_completion_model.dart';

abstract interface class ProfileRepository {
  FutureEither<ProfileDataModel> getProfile();
  FutureEither<String> switchRole({required RolesModel roles});
  FutureEither<String> setUpProfile({
    required UserProfileSetUpModel profileSetUpModel,
  });
  FutureEither<ProfileCompletionModel> checkProfileCompletion();
  FutureEither<String> updateProfile({
    required Map<String, dynamic> data,
    String? profileImagePath,
    String? bannerImagePath,
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

  @override
  FutureEither<String> switchRole({required RolesModel roles}) async {
    final response = await _apiService.post<Map>(
      'profile/switch-role/',
      data: roles,
    );

    return response.fold((failure) => Left(failure), (data) {
      return Right(data['message']);
    });
  }

  @override
  FutureEither<ProfileCompletionModel> checkProfileCompletion() async {
    final response = await _apiService.get('profile/completion-check/');

    return response.fold((failure) => Left(failure), (data) {
      final completionData = data['data'];
      final completionModel = ProfileCompletionModel.fromJson(completionData);
      return Right(completionModel);
    });
  }

  @override
  FutureEither<String> updateProfile({
    required Map<String, dynamic> data,
    String? profileImagePath,
    String? bannerImagePath,
  }) async {
    Map<String, dynamic> mapData = Map.from(data);

    if (profileImagePath != null) {
      mapData['profile_image'] = await MultipartFile.fromFile(
        profileImagePath,
        filename: profileImagePath.split('/').last,
      );
    }

    if (bannerImagePath != null) {
      mapData['banner_image'] = await MultipartFile.fromFile(
        bannerImagePath,
        filename: bannerImagePath.split('/').last,
      );
    }

    FormData formData = FormData.fromMap(mapData);

    final response = await _apiService.patch('profile/update/', data: formData);

    return response.fold((failure) => Left(failure), (data) {
      return Right(data['message']);
    });
  }
}
