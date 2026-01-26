class SessionModel {
  final int id;
  final Map<String, dynamic> learner;
  final Map<String, dynamic> mentor;
  final String skill;
  final DateTime scheduledTime;
  final int durationMinutes;
  final int points;
  final String status;
  final String? meetingLink;
  final DateTime createdAt;

  const SessionModel({
    required this.id,
    required this.learner,
    required this.mentor,
    required this.skill,
    required this.scheduledTime,
    required this.durationMinutes,
    required this.points,
    required this.status,
    this.meetingLink,
    required this.createdAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as int,
      learner: json['learner'] as Map<String, dynamic>,
      mentor: json['mentor'] as Map<String, dynamic>,
      skill: json['skill'] as String,
      scheduledTime: DateTime.parse(json['scheduled_time'] as String),
      durationMinutes: json['duration_minutes'] as int,
      points: json['points'] as int,
      status: json['status'] as String,
      meetingLink: json['meeting_link'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'learner': learner,
      'mentor': mentor,
      'skill': skill,
      'scheduled_time': scheduledTime.toIso8601String(),
      'duration_minutes': durationMinutes,
      'points': points,
      'status': status,
      'meeting_link': meetingLink,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
