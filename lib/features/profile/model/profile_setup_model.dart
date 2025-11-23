import 'dart:convert';
import 'dart:io';

class UserProfileSetUpModel {
  final File? profileImage;
  final String? profileTitle;
  final String? profileDescription;
  final String? phoneNumber;
  final String? fullName;
  final String? bio;
  final String? locationProvince;
  final List<String>? skillYouOffer;
  final List<String>? skillYouWantToLearn;

  UserProfileSetUpModel({
    this.profileImage,
    this.profileTitle,
    this.profileDescription,
    this.phoneNumber,
    this.fullName,
    this.bio,
    this.locationProvince,
    this.skillYouOffer,
    this.skillYouWantToLearn,
  });

  /// ---------- FROM JSON ----------
  factory UserProfileSetUpModel.fromJson(Map<String, dynamic> json) {
    return UserProfileSetUpModel(
      profileTitle: json["profile_title"],
      profileDescription: json["profile_description"],
      phoneNumber: json["phone_number"],
      fullName: json["full_name"],
      bio: json["bio"],
      locationProvince: json["location_province"],
      skillYouOffer: _parseStringList(json["skill_you_offer"]),
      skillYouWantToLearn: _parseStringList(json["skill_you_want_to_learn"]),
    );
  }

  /// ---------- TO JSON ----------
  Map<String, dynamic> toJson() {
    return {
      "profile_title": profileTitle,
      "profile_description": profileDescription,
      "phone_number": phoneNumber,
      "full_name": fullName,
      "bio": bio,
      "location_province": locationProvince,
      "skill_you_offer": skillYouOffer,
      "skill_you_want_to_learn": skillYouWantToLearn,
    };
  }

  /// ---------- FROM MAP ----------
  factory UserProfileSetUpModel.fromMap(Map<String, dynamic> map) {
    return UserProfileSetUpModel(
      profileTitle: map["profile_title"],
      profileDescription: map["profile_description"],
      phoneNumber: map["phone_number"],
      fullName: map["full_name"],
      bio: map["bio"],
      locationProvince: map["location_province"],
      skillYouOffer: _parseStringList(map["skill_you_offer"]),
      skillYouWantToLearn: _parseStringList(map["skill_you_want_to_learn"]),
    );
  }

  /// ---------- TO MAP ----------
  Map<String, dynamic> toMap() {
    return {
      "profile_title": profileTitle,
      "profile_description": profileDescription,
      "phone_number": phoneNumber,
      "full_name": fullName,
      "bio": bio,
      "location_province": locationProvince,
      "skill_you_offer": skillYouOffer != null
          ? jsonEncode(skillYouOffer)
          : "[]",
      "skill_you_want_to_learn": skillYouWantToLearn != null
          ? jsonEncode(skillYouWantToLearn)
          : "[]",
    };
  }

  Map<String, String> listToMap(List<String>? list) {
    return {for (var e in list ?? []) e: e};
  }

  /// ---------- HELPERS ----------
  static List<String>? _parseStringList(dynamic value) {
    if (value == null) return null;

    try {
      if (value is List) {
        return value.map((item) => item.toString()).toList();
      }

      // When API returns string like: '["React", "Vue"]'
      if (value is String) {
        final cleaned = value
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll('"', "")
            .split(",");

        return cleaned.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
