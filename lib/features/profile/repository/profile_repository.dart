import 'dart:convert';
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

  String? _extractLocalPath(String path) {
    if (path.isEmpty) return null;

    // Remove Flutter log junk if present
    if (path.contains('║')) {
      path = path.split('║').last.trim();
    }

    // Handle mangled URLs that contain local paths
    if (path.startsWith('http')) {
      // Look for common mobile local path markers
      final localMarkers = ['/data/user/', '/cache/', '/Document/'];
      for (final marker in localMarkers) {
        if (path.contains(marker)) {
          return marker + path.split(marker).last;
        }
      }
      return null; // It's a real network image
    }

    return path;
  }

  String _getCleanFileName(String path) {
    // Get the part after the last slash
    String name = path.split('/').last;

    // If there's still junk (e.g. from log lines), take the last part
    if (name.contains(' ')) {
      name = name.split(' ').last;
    }
    if (name.contains(':')) {
      name = name.split(':').last;
    }

    // Ensure it has a reasonable name, especially if it's image_cropper
    if (name.contains('image_cropper_') &&
        !name.endsWith('.jpg') &&
        !name.endsWith('.png')) {
      // Fallback or try to find the full image_cropper name
      RegExp regExp = RegExp(r'image_cropper_\d+\.(?:jpg|png|jpeg)');
      var match = regExp.firstMatch(path);
      if (match != null) {
        return match.group(0)!;
      }
    }

    return name.trim();
  }

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
              filename: _getCleanFileName(profileSetUpModel.profileImage!.path),
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
        filename: _getCleanFileName(profileImagePath),
      );
    }

    if (bannerImagePath != null) {
      mapData['banner_image'] = await MultipartFile.fromFile(
        bannerImagePath,
        filename: _getCleanFileName(bannerImagePath),
      );
    }

    // Handle nested files for certifications, work_experience, and portfolio
    final nestedFields = ['certifications', 'work_experience', 'portfolio'];
    for (final field in nestedFields) {
      if (mapData[field] != null && mapData[field] is String) {
        try {
          List items = jsonDecode(mapData[field]);
          bool modified = false;
          for (int i = 0; i < items.length; i++) {
            final item = items[i];
            if (item is Map && item.containsKey('image')) {
              String? imagePath = item['image'];
              if (imagePath != null && imagePath.isNotEmpty) {
                String? localPath = _extractLocalPath(imagePath);

                if (localPath != null && localPath.isNotEmpty) {
                  // It's a local path or a mangled URL that we extracted a local path from
                  String fileKey = '${field}_image_$i';
                  String fileName = _getCleanFileName(localPath);

                  mapData[fileKey] = await MultipartFile.fromFile(
                    localPath,
                    filename: fileName,
                  );
                  // Mark in JSON that this is a file reference for the backend
                  item['image'] = 'file:$fileKey';
                  modified = true;
                }
              }
            }
          }
          if (modified) {
            mapData[field] = jsonEncode(items);
          }
        } catch (e) {
          // If decoding fails, skip this field
        }
      }
    }

    FormData formData = FormData.fromMap(mapData);

    final response = await _apiService.patch('profile/update/', data: formData);

    return response.fold((failure) => Left(failure), (data) {
      return Right(data['message']);
    });
  }
}
