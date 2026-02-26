import 'dart:convert';

import 'package:skill_swap/features/profile/model/working_exprience_model.dart';
import 'certification_model.dart';

/// Profile data model
class ProfileDataModel {
  final String? profileImage;
  final String profileTitle;
  final String email;
  final String phoneNumber;
  final bool? phoneVerified;
  final String fullName;
  final int? points;
  final int? heldPoints;
  final String? profileDescription;
  final String? bio;
  final String? locationProvince;
  final List<String> skillYouOffer;
  final List<String> skillYouWantToLearn;
  final String? bannerImage;
  final List<CertificationModel> certifications;
  final List<WorkingExprienceModel> workingExpriences;
  final List<dynamic> portfolio;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> roles;
  final DateTime? lastLoginRewardPoints;
  final int? totalStudents;
  final int? dailyPointsEarned;
  final int? id;

  ProfileDataModel({
    this.profileImage,
    required this.profileTitle,
    required this.email,
    required this.phoneNumber,
    this.phoneVerified,
    this.points,
    this.heldPoints,
    required this.fullName,
    this.profileDescription,
    this.bio,
    this.locationProvince,
    List<String>? skillYouOffer,
    List<String>? skillYouWantToLearn,
    List<String>? roles,
    this.bannerImage,
    List<CertificationModel>? certifications,
    List<WorkingExprienceModel>? workingExpriences,
    List<dynamic>? portfolio,
    this.createdAt,
    this.updatedAt,
    this.lastLoginRewardPoints,
    this.totalStudents,
    this.dailyPointsEarned,
    this.id,
  }) : skillYouOffer = skillYouOffer ?? [],
       skillYouWantToLearn = skillYouWantToLearn ?? [],
       certifications = certifications ?? [],
       workingExpriences = workingExpriences ?? [],
       roles = roles ?? [],
       portfolio = portfolio ?? [];

  factory ProfileDataModel.fromMap(Map<String, dynamic> map) {
    List<String> parseStringList(dynamic value) {
      if (value == null) return <String>[];
      if (value is List) {
        return value
            .map((e) => e?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return <String>[];
    }

    List<CertificationModel> parseCertificationList(dynamic value) {
      if (value == null) return <CertificationModel>[];
      if (value is List) {
        return value
            .map((e) => CertificationModel.fromMap(e as Map<String, dynamic>))
            .toList();
      }
      return <CertificationModel>[];
    }

    List<WorkingExprienceModel> parseWorkingExperience(dynamic value) {
      if (value == null) return <WorkingExprienceModel>[];
      if (value is List) {
        return value
            .map(
              (e) => WorkingExprienceModel.fromMap(e as Map<String, dynamic>),
            )
            .toList();
      }
      return <WorkingExprienceModel>[];
    }

    DateTime? tryParseDate(String? s) {
      if (s == null) return null;
      try {
        return DateTime.parse(s);
      } catch (_) {
        return null;
      }
    }

    return ProfileDataModel(
      profileImage: map['profile_image'] as String?,
      profileTitle: map['profile_title']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      phoneNumber: map['phone_number']?.toString() ?? '',
      phoneVerified: map['phone_verified'] as bool? ?? false,
      points: map['points'] is int
          ? map['points']
          : int.tryParse(map['points']?.toString() ?? ''),
      heldPoints: map['held_points'] is int
          ? map['held_points']
          : int.tryParse(map['held_points']?.toString() ?? ''),
      fullName: map['full_name']?.toString() ?? '',
      profileDescription: map['profile_description'] as String?,
      bio: map['bio'] as String?,
      locationProvince: map['location_province'] as String?,
      skillYouOffer: parseStringList(map['skill_you_offer']),
      skillYouWantToLearn: parseStringList(map['skill_you_want_to_learn']),
      bannerImage: map['banner_image'] as String?,
      certifications: parseCertificationList(map['certifications']),
      workingExpriences: parseWorkingExperience(map['work_experience']),
      portfolio: map['portfolio'] is List
          ? List<dynamic>.from(map['portfolio'])
          : [],
      createdAt: tryParseDate(map['created_at']),
      updatedAt: tryParseDate(map['updated_at']),
      lastLoginRewardPoints: tryParseDate(map['last_login_reward_points']),
      totalStudents: map['total_students'] as int?,
      dailyPointsEarned: map['daily_points_earned'] as int?,
      roles: parseStringList(map['roles']).isNotEmpty
          ? parseStringList(map['roles'])
          : ['LEARNER'],
      id: map['id'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profile_image': profileImage,
      'profile_title': profileTitle,
      'email': email,
      'phone_number': phoneNumber,
      'phone_verified': phoneVerified,
      'points': points,
      'held_points': heldPoints,
      'full_name': fullName,
      'profile_description': profileDescription,
      'bio': bio,
      'location_province': locationProvince,
      'skill_you_offer': skillYouOffer,
      'skill_you_want_to_learn': skillYouWantToLearn,
      'banner_image': bannerImage,
      'certifications': certifications.map((e) => e.toMap()).toList(),
      'work_experience': workingExpriences.map((e) => e.toMap()).toList(),
      'portfolio': portfolio,
      'created_at': createdAt?.toUtc().toIso8601String(),
      'updated_at': updatedAt?.toUtc().toIso8601String(),
      'roles': roles,
      'last_login_reward_points': lastLoginRewardPoints?.toIso8601String(),
      'total_students': totalStudents,
      'daily_points_earned': dailyPointsEarned,
    };
  }

  String toJson() => json.encode(toMap());

  ProfileDataModel copyWith({
    String? profileImage,
    String? profileTitle,
    String? profileDescription,
    String? email,
    String? phoneNumber,
    int? points,
    int? heldPoints,
    bool? phoneVerified,
    String? fullName,
    String? bio,
    String? locationProvince,
    List<String>? skillYouOffer,
    List<String>? skillYouWantToLearn,
    String? bannerImage,
    List<CertificationModel>? certifications,
    List<WorkingExprienceModel>? workingExpriences,
    List<dynamic>? portfolio,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? roles,
    DateTime? lastLoginRewardPoints,
    int? totalStudents,
    int? dailyPointsEarned,
  }) {
    return ProfileDataModel(
      profileImage: profileImage ?? this.profileImage,
      profileTitle: profileTitle ?? this.profileTitle,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      points: points ?? this.points,
      heldPoints: heldPoints ?? this.heldPoints,
      fullName: fullName ?? this.fullName,
      profileDescription: profileDescription ?? this.profileDescription,
      bio: bio ?? this.bio,
      locationProvince: locationProvince ?? this.locationProvince,
      skillYouOffer: skillYouOffer ?? List<String>.from(this.skillYouOffer),
      skillYouWantToLearn:
          skillYouWantToLearn ?? List<String>.from(this.skillYouWantToLearn),
      bannerImage: bannerImage ?? this.bannerImage,
      certifications:
          certifications ?? List<CertificationModel>.from(this.certifications),
      workingExpriences:
          workingExpriences ??
          List<WorkingExprienceModel>.from(this.workingExpriences),
      portfolio: portfolio ?? List<dynamic>.from(this.portfolio),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      roles: roles ?? List<String>.from(this.roles),
      lastLoginRewardPoints:
          lastLoginRewardPoints ?? this.lastLoginRewardPoints,
      totalStudents: totalStudents ?? this.totalStudents,
      dailyPointsEarned: dailyPointsEarned ?? this.dailyPointsEarned,
    );
  }

  @override
  String toString() {
    return 'ProfileData(fullName: $fullName, profileTitle: $profileTitle, email: $email, phoneNumber: $phoneNumber, points: $points)';
  }
}
