class AvailabilityRangeModel {
  final DateTime startTime;
  final DateTime endTime;
  final int durationMinutes;

  AvailabilityRangeModel({
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
  });

  Map<String, dynamic> toJson() {
    return {
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'duration_minutes': durationMinutes,
    };
  }

  factory AvailabilityRangeModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityRangeModel(
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      durationMinutes: json['duration_minutes'] as int,
    );
  }
}
