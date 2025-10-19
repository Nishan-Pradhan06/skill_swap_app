import 'dart:convert';

class OnboardingModel {
  String imageUrl;
  String headline;
  String description;
  OnboardingModel({
    required this.imageUrl,
    required this.headline,
    required this.description,
  });

  OnboardingModel copyWith({
    String? imageUrl,
    String? headline,
    String? description,
  }) {
    return OnboardingModel(
      imageUrl: imageUrl ?? this.imageUrl,
      headline: headline ?? this.headline,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'headline': headline,
      'description': description,
    };
  }

  factory OnboardingModel.fromMap(Map<String, dynamic> map) {
    return OnboardingModel(
      imageUrl: map['imageUrl'] ?? '',
      headline: map['headline'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingModel.fromJson(String source) =>
      OnboardingModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OnboardingData(imageUrl: $imageUrl, headline: $headline, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingModel &&
        other.imageUrl == imageUrl &&
        other.headline == headline &&
        other.description == description;
  }

  @override
  int get hashCode =>
      imageUrl.hashCode ^ headline.hashCode ^ description.hashCode;
}

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: 'AppImages.onboarding1',
      headline: 'Browse all the category',
      description:
          'In aliquip aute exercitation ut et nisi ut mollit. Deserunt dolor elit pariatur aute .',
    ),
    OnboardingModel(
      imageUrl: 'assets/svg/on_boarding/on_boarding1.png',
      headline: 'Amazing Discounts & Offers',
      description:
          'In aliquip aute exercitation ut et nisi ut mollit. Deserunt dolor elit pariatur aute .',
    ),
    OnboardingModel(
      imageUrl: 'AppImages.onboarding3',
      headline: 'Delivery in 30 Min',
      description:
          'In aliquip aute exercitation ut et nisi ut mollit. Deserunt dolor elit pariatur aute .',
    ),
  ];
}
