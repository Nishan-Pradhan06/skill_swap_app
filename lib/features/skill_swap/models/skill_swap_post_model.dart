class SkillSwapPostModel {
  final int id;
  final PostUserModel user;
  final String title;
  final String description;
  final PostCategoryModel? category;
  final String skillOffered;
  final String skillWanted;
  final String? teachDate;
  final String? teachTime;
  final String? learnDate;
  final String? learnTime;
  final int pointsReward;
  final int pointsCost;
  final bool isActive;
  final DateTime createdAt;
  final int? availableSlotsCount;
  final int? totalSlotsCount;

  SkillSwapPostModel({
    required this.id,
    required this.user,
    required this.title,
    required this.description,
    this.category,
    required this.skillOffered,
    required this.skillWanted,
    this.teachDate,
    this.teachTime,
    this.learnDate,
    this.learnTime,
    required this.pointsReward,
    required this.pointsCost,
    required this.isActive,
    required this.createdAt,
    this.availableSlotsCount,
    this.totalSlotsCount,
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
      skillOffered: json['skill_offered'],
      skillWanted: json['skill_wanted'],
      teachDate: json['teach_date'],
      teachTime: json['teach_time'],
      learnDate: json['learn_date'],
      learnTime: json['learn_time'],
      pointsReward: json['points_reward'],
      pointsCost: json['points_cost'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      availableSlotsCount: json['available_slots_count'],
      totalSlotsCount: json['total_slots_count'],
    );
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
