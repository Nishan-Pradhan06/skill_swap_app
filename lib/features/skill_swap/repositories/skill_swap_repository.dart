import 'package:dartz/dartz.dart';
import 'package:skill_swap/common/typedef/either_type.dart';
import 'package:skill_swap/core/network/api_services.dart';
import 'package:skill_swap/features/skill_swap/models/availability_slot_model.dart';
import 'package:skill_swap/features/skill_swap/models/skill_swap_post_model.dart';

abstract interface class SkillSwapRepository {
  FutureEither<List<PostCategoryModel>> getCategories();

  FutureEither<String> setAvailability({
    required DateTime startTime,
    required DateTime endTime,
    required int durationMinutes,
    int? postId,
  });

  FutureEither<List<AvailabilitySlotModel>> getAvailability({
    int? mentorId,
    int? postId,
  });

  FutureEither<List<SkillSwapPostModel>> getSkillSwapPosts();

  FutureEither<List<SkillSwapPostModel>> getMentorPosts();

  FutureEither<String> createPost({
    required String title,
    required String description,
    required int categoryId,
    required String skillOffered,
    required String skillWanted,
    required int pointsReward,
    required int pointsCost,
    Map<String, dynamic>? availability,
  });

  FutureEither<String> updatePost({
    required int postId,
    String? title,
    String? description,
    int? categoryId,
    String? skillOffered,
    String? skillWanted,
    int? pointsReward,
    int? pointsCost,
    Map<String, dynamic>? availability,
  });

  FutureEither<String> deletePost(int postId);

  FutureEither<String> bookSession({
    required int mentorId,
    required int slotId,
    required String skill,
    required int points,
    required DateTime scheduledTime,
    required int durationMinutes,
  });

  FutureEither<List<dynamic>> getSessions({required String role});

  FutureEither<String> sessionAction({
    required int sessionId,
    required String action,
  });

  FutureEither<String> addCategory({required String name});
}

class SkillSwapRepositoryImpl implements SkillSwapRepository {
  final ApiService _apiService;

  SkillSwapRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<List<PostCategoryModel>> getCategories() async {
    final response = await _apiService.get<List>('skillswap/categories/');

    return response.fold((failure) => Left(failure), (data) {
      final List<PostCategoryModel> categories = data
          .map((e) => PostCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(categories);
    });
  }

  @override
  FutureEither<String> setAvailability({
    required DateTime startTime,
    required DateTime endTime,
    required int durationMinutes,
    int? postId,
  }) async {
    final response = await _apiService.post<Map>(
      'availability/set/',
      data: {
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "duration_minutes": durationMinutes,
        "post_id": postId,
      },
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data['message'] ?? "Availability set successfully"),
    );
  }

  @override
  FutureEither<List<AvailabilitySlotModel>> getAvailability({
    int? mentorId,
    int? postId,
  }) async {
    final Map<String, dynamic> queryParams = {};
    if (mentorId != null) queryParams["mentor_id"] = mentorId;
    if (postId != null) queryParams["post_id"] = postId;

    final response = await _apiService.get<List>(
      'availability/get/',
      queryParameters: queryParams,
    );

    return response.fold((failure) => Left(failure), (data) {
      final List<AvailabilitySlotModel> slots = data
          .map((e) => AvailabilitySlotModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(slots);
    });
  }

  @override
  FutureEither<List<SkillSwapPostModel>> getSkillSwapPosts() async {
    final response = await _apiService.get<List>('skillswap/posts/');

    return response.fold((failure) => Left(failure), (data) {
      final List<SkillSwapPostModel> posts = data
          .map((e) => SkillSwapPostModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(posts);
    });
  }

  @override
  FutureEither<List<SkillSwapPostModel>> getMentorPosts() async {
    final response = await _apiService.get<List>('skillswap/posts/mentor/');

    return response.fold((failure) => Left(failure), (data) {
      final List<SkillSwapPostModel> posts = data
          .map((e) => SkillSwapPostModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(posts);
    });
  }

  @override
  FutureEither<String> createPost({
    required String title,
    required String description,
    required int categoryId,
    required String skillOffered,
    required String skillWanted,
    required int pointsReward,
    required int pointsCost,
    Map<String, dynamic>? availability,
  }) async {
    final response = await _apiService.post<Map>(
      'skillswap/posts/create/',
      data: {
        "title": title,
        "description": description,
        "category": categoryId,
        "skill_offered": skillOffered,
        "skill_wanted": skillWanted,
        "points_reward": pointsReward,
        "points_cost": pointsCost,
        "availability": availability,
      },
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data['message'] ?? "Post created successfully"),
    );
  }

  @override
  FutureEither<String> updatePost({
    required int postId,
    String? title,
    String? description,
    int? categoryId,
    String? skillOffered,
    String? skillWanted,
    int? pointsReward,
    int? pointsCost,
    Map<String, dynamic>? availability,
  }) async {
    final Map<String, dynamic> data = {
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (categoryId != null) "category": categoryId,
      if (skillOffered != null) "skill_offered": skillOffered,
      if (skillWanted != null) "skill_wanted": skillWanted,
      if (pointsReward != null) "points_reward": pointsReward,
      if (pointsCost != null) "points_cost": pointsCost,
      if (availability != null) "availability": availability,
    };

    final response = await _apiService.patch<Map>(
      'skillswap/posts/$postId/update/',
      data: data,
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data['message'] ?? "Post updated successfully"),
    );
  }

  @override
  FutureEither<String> deletePost(int postId) async {
    final response = await _apiService.delete<Map>(
      'skillswap/posts/$postId/delete/',
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data['message'] ?? "Post deleted successfully"),
    );
  }

  @override
  FutureEither<String> bookSession({
    required int mentorId,
    required int slotId,
    required String skill,
    required int points,
    required DateTime scheduledTime,
    required int durationMinutes,
  }) async {
    final response = await _apiService.post<Map>(
      'skillswap/request/create/',
      data: {
        "mentor_id": mentorId,
        "availability_slot_id": slotId,
        "skill": skill,
        "points": points,
        "scheduled_time": scheduledTime.toIso8601String(),
        "duration_minutes": durationMinutes,
      },
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data['message'] ?? "Session booked successfully"),
    );
  }

  @override
  FutureEither<List<dynamic>> getSessions({required String role}) async {
    final response = await _apiService.get<List>(
      'skillswap/sessions/',
      queryParameters: {"role": role},
    );

    return response.fold((failure) => Left(failure), (data) {
      // We will parse this into models later
      return Right(data);
    });
  }

  @override
  FutureEither<String> sessionAction({
    required int sessionId,
    required String action,
  }) async {
    final response = await _apiService.post<Map>(
      'skillswap/sessions/$sessionId/action/',
      data: {"action": action},
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data['message'] ?? "Action successful"),
    );
  }

  @override
  FutureEither<String> addCategory({required String name}) async {
    final response = await _apiService.post<Map>(
      'skillswap/categories/',
      data: {"name": name},
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data['name'] ?? "Category added successfully"),
    );
  }
}
