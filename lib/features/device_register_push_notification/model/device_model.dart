import 'dart:convert';

class DeviceRegisterModel {
  final String platform;
  final String token;

  DeviceRegisterModel({required this.platform, required this.token});

  /// Create an instance from a Map
  factory DeviceRegisterModel.fromMap(Map<String, dynamic> map) {
    return DeviceRegisterModel(
      platform: map['platform'] ?? '',
      token: map['token'] ?? '',
    );
  }

  /// Convert the instance to a Map
  Map<String, dynamic> toMap() {
    return {'platform': platform, 'token': token};
  }

  /// Create an instance from a JSON string
  factory DeviceRegisterModel.fromJson(String source) =>
      DeviceRegisterModel.fromMap(json.decode(source));

  /// Convert the instance to a JSON string
  String toJson() => json.encode(toMap());
}
