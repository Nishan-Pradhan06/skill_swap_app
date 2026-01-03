class RolesModel {
  final List<String> roles;

  RolesModel({required this.roles});

  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(roles: List<String>.from(json['roles'] ?? []));
  }

  Map<String, dynamic> toJson() {
    return {'roles': roles};
  }
}
