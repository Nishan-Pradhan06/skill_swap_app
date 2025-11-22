class SignUpModel {
  final String email;
  final String password;
  final String confirmPassword;
  SignUpModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    };
  }
}
