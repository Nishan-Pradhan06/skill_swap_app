class RolesModel {
  final String role; // single role

  RolesModel({required this.role});

  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(role: json['role'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
    };
  }
}
