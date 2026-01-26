class AvailabilitySlotModel {
  final int id;
  final int mentorId;
  final DateTime startTime;
  final DateTime endTime;
  final bool isBooked;
  final int? postId;

  const AvailabilitySlotModel({
    required this.id,
    required this.mentorId,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
    this.postId,
  });

  factory AvailabilitySlotModel.fromJson(Map<String, dynamic> json) {
    return AvailabilitySlotModel(
      id: json['id'] as int,
      mentorId: json['mentor'] as int,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      isBooked: json['is_booked'] as bool,
      postId: json['post'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mentor': mentorId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'is_booked': isBooked,
      'post': postId,
    };
  }
}
