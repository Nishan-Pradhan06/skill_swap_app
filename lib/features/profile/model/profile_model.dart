import 'dart:convert';

/// Profile data model
class ProfileDataModel {
  final String? profileImage;
  final String profileTitle;
  final String? profileDescription;
  final String? phoneNumber;
  final bool? phoneVerified;
  final String fullName;
  final String? bio;
  final String? locationProvince;
  final List<String> skillYouOffer;
  final List<String> skillYouWantToLearn;
  final String? bannerImage;
  final List<dynamic> certifications;
  final List<dynamic> workExperience;
  final List<dynamic> portfolio;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProfileDataModel({
    this.profileImage,
    required this.profileTitle,
    this.profileDescription,
    this.phoneNumber,
    this.phoneVerified,
    required this.fullName,
    this.bio,
    this.locationProvince,
    List<String>? skillYouOffer,
    List<String>? skillYouWantToLearn,
    this.bannerImage,
    List<dynamic>? certifications,
    List<dynamic>? workExperience,
    List<dynamic>? portfolio,
    this.createdAt,
    this.updatedAt,
  }) : skillYouOffer = skillYouOffer ?? [],
       skillYouWantToLearn = skillYouWantToLearn ?? [],
       certifications = certifications ?? [],
       workExperience = workExperience ?? [],
       portfolio = portfolio ?? [];

  factory ProfileDataModel.fromMap(Map<String, dynamic> map) {
    // safe parsing for lists of strings
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

    // general list parsing (keeps raw objects)
    List<dynamic> parseDynamicList(dynamic value) {
      if (value == null) return <dynamic>[];
      if (value is List) return List<dynamic>.from(value);
      return <dynamic>[];
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
      profileTitle: map['profile_title'],
      profileDescription: map['profile_description'] as String?,
      phoneNumber: map['phone_number'] as String?,
      phoneVerified: map['phone_verified'] as bool? ?? false,
      fullName: map['full_name'],
      bio: map['bio'] as String?,
      locationProvince: map['location_province'] as String?,
      skillYouOffer: parseStringList(map['skill_you_offer']),
      skillYouWantToLearn: parseStringList(map['skill_you_want_to_learn']),
      bannerImage: map['banner_image'] as String?,
      certifications: parseDynamicList(map['certifications']),
      workExperience: parseDynamicList(map['work_experience']),
      portfolio: parseDynamicList(map['portfolio']),
      createdAt: tryParseDate(map['created_at'] as String?),
      updatedAt: tryParseDate(map['updated_at'] as String?),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profile_image': profileImage,
      'profile_title': profileTitle,
      'profile_description': profileDescription,
      'phone_number': phoneNumber,
      'phone_verified': phoneVerified,
      'full_name': fullName,
      'bio': bio,
      'location_province': locationProvince,
      'skill_you_offer': skillYouOffer,
      'skill_you_want_to_learn': skillYouWantToLearn,
      'banner_image': bannerImage,
      'certifications': certifications,
      'work_experience': workExperience,
      'portfolio': portfolio,
      'created_at': createdAt?.toUtc().toIso8601String(),
      'updated_at': updatedAt?.toUtc().toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  ProfileDataModel copyWith({
    String? profileImage,
    String? profileTitle,
    String? profileDescription,
    String? phoneNumber,
    bool? phoneVerified,
    String? fullName,
    String? bio,
    String? locationProvince,
    List<String>? skillYouOffer,
    List<String>? skillYouWantToLearn,
    String? bannerImage,
    List<dynamic>? certifications,
    List<dynamic>? workExperience,
    List<dynamic>? portfolio,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileDataModel(
      profileImage: profileImage ?? this.profileImage,
      profileTitle: profileTitle ?? this.profileTitle,
      profileDescription: profileDescription ?? this.profileDescription,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      fullName: fullName ?? this.fullName,
      bio: bio ?? this.bio,
      locationProvince: locationProvince ?? this.locationProvince,
      skillYouOffer: skillYouOffer ?? List<String>.from(this.skillYouOffer),
      skillYouWantToLearn:
          skillYouWantToLearn ?? List<String>.from(this.skillYouWantToLearn),
      bannerImage: bannerImage ?? this.bannerImage,
      certifications: certifications ?? List<dynamic>.from(this.certifications),
      workExperience: workExperience ?? List<dynamic>.from(this.workExperience),
      portfolio: portfolio ?? List<dynamic>.from(this.portfolio),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'ProfileData(fullName: $fullName, profileTitle: $profileTitle, phone: $phoneNumber)';
  }
}
