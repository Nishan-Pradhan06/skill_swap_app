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
      imageUrl: 'assets/svg/on_boarding/on_boarding2.svg',
      headline: 'Turn Your \nPassion into a Purpose !',
      description:
          'Discover, share, and grow your skills with people who inspire you - all from one place!',
    ),
    OnboardingModel(
      imageUrl: 'assets/svg/on_boarding/on_boarding1.svg',
      headline: 'Learn New Skill,\nTeach What you love',
      description:
          'Exchange your talents — find learners for what you teach and mentors for what you seek to learn.',
    ),
    OnboardingModel(
      imageUrl: 'assets/svg/on_boarding/on_boarding3.svg',
      headline: 'Connect.\nCollaborate.\nGrow Together.',
      description:
          'Join a global community where you can swap skills, earn experience, and empower each other to achieve more.',
    ),
  ];
}
