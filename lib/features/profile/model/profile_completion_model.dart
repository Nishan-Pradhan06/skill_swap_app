class ProfileCompletionModel {
  final bool isComplete;
  final List<String> missingFields;

  const ProfileCompletionModel({
    required this.isComplete,
    required this.missingFields,
  });

  factory ProfileCompletionModel.fromJson(Map<String, dynamic> json) {
    return ProfileCompletionModel(
      isComplete: json['is_complete'] as bool,
      missingFields:
          (json['missing_fields'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'is_complete': isComplete, 'missing_fields': missingFields};
  }

  @override
  String toString() {
    return 'ProfileCompletionModel(isComplete: $isComplete, missingFields: $missingFields)';
  }
}
