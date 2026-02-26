import 'package:skill_swap/core/utils/date_string_split_utils.dart';
import 'package:skill_swap/features/skill_swap/models/availability_slot_model.dart';

class SkillSwapPostModel {
  final int id;
  final PostUserModel user;
  final String title;
  final String description;
  final PostCategoryModel? category;
  final String skillToLearn;
  final String? teachDate;
  final String? teachTime;
  final String? teachEndDate;
  final String? teachEndTime;
  final String? learnDate;
  final String? learnTime;
  final int pointsCost;
  final int durationMinutes;
  final bool isActive;
  final DateTime createdAt;
  final int? availableSlotsCount;
  final int? totalSlotsCount;
  final List<AvailabilitySlotModel>? availabilitySlots;

  SkillSwapPostModel({
    required this.id,
    required this.user,
    required this.title,
    required this.description,
    this.category,
    required this.skillToLearn,
    this.teachDate,
    this.teachTime,
    this.teachEndDate,
    this.teachEndTime,
    this.learnDate,
    this.learnTime,
    required this.pointsCost,
    this.durationMinutes = 60,
    required this.isActive,
    required this.createdAt,
    this.availableSlotsCount,
    this.totalSlotsCount,
    this.availabilitySlots,
  });

  factory SkillSwapPostModel.fromJson(Map<String, dynamic> json) {
    return SkillSwapPostModel(
      id: json['id'],
      user: PostUserModel.fromJson(json['user']),
      title: json['title'],
      description: json['description'],
      category: json['category'] != null
          ? PostCategoryModel.fromJson(json['category'])
          : null,
      skillToLearn: json['skill_to_learn'],
      teachDate: json['teach_date'],
      teachTime: json['teach_time'],
      teachEndDate: json['teach_end_date'],
      teachEndTime: json['teach_end_time'],
      learnDate: json['learn_date'],
      learnTime: json['learn_time'],
      pointsCost: json['points_cost'],
      durationMinutes: json['duration_minutes'] ?? 60,
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      availableSlotsCount: json['available_slots_count'],
      totalSlotsCount: json['total_slots_count'],
      availabilitySlots: json['availability_slots'] != null
          ? (json['availability_slots'] as List)
                .map((i) => AvailabilitySlotModel.fromJson(i))
                .toList()
          : null,
    );
  }

  String get availabilityRange {
    if (teachDate == null) return "Not specified";
    try {
      final startDate = DateTime.parse(teachDate!);
      String startStr = DateTimeUtils.getDay(startDate);
      if (teachTime != null) {
        final startWithTime = DateTime.parse(
          "${teachDate}T${teachTime}Z",
        ).toLocal();
        startStr = DateTimeUtils.formatDateTimeNoDay(startWithTime);
      }

      if (teachEndDate != null) {
        final endDate = DateTime.parse(teachEndDate!);
        String endStr = DateTimeUtils.formatDate(endDate);
        if (teachEndTime != null) {
          final endWithTime = DateTime.parse(
            "${teachEndDate}T${teachEndTime}Z",
          ).toLocal();
          endStr = DateTimeUtils.formatDateTimeNoDay(endWithTime);
        }
        return "$startStr - $endStr";
      }
      return startStr;
    } catch (e) {
      // Fallback to simple string concat if parsing fails
      String start = "$teachDate ${teachTime ?? ""}";
      if (teachEndDate != null) {
        String end = "$teachEndDate ${teachEndTime ?? ""}";
        return "$start - $end";
      }
      return start;
    }
  }
}

class PostUserModel {
  final int id;
  final String fullName;
  final String? profileImage;
  final int points;
  final String? mainCategory;
  final List<String> subCategory;

  PostUserModel({
    required this.id,
    required this.fullName,
    this.profileImage,
    required this.points,
    this.mainCategory,
    required this.subCategory,
  });

  factory PostUserModel.fromJson(Map<String, dynamic> json) {
    return PostUserModel(
      id: json['id'],
      fullName: json['full_name'] ?? '',
      profileImage: json['profile_image'],
      points: json['points'] ?? 0,
      mainCategory: json['main_category'],
      subCategory: List<String>.from(json['sub_category'] ?? []),
    );
  }
}

class PostCategoryModel {
  final int id;
  final String name;

  PostCategoryModel({required this.id, required this.name});

  factory PostCategoryModel.fromJson(Map<String, dynamic> json) {
    return PostCategoryModel(id: json['id'], name: json['name']);
  }
}
