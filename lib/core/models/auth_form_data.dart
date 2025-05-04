import 'dart:io';

enum AuthMode { signup, login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _authMode = AuthMode.login;

  bool get isLogin => _authMode == AuthMode.login;
  bool get isSignup => _authMode == AuthMode.signup;

  void toggleAuthMode() => _authMode = _authMode == AuthMode.login ? AuthMode.signup : AuthMode.login;

  // Map<String, dynamic> toJson() {
  //   return {'name': name, 'email': email, 'password': password, 'image': image?.path};
  // }
  //
  // factory AuthFormData.fromJson(Map<String, dynamic> json) {
  //   return AuthFormData(
  //     name: json['name'] as String,
  //     email: json['email'] as String,
  //     password: json['password'] as String,
  //     json['image'] != null ? File(json['image']) : null,
  //   );
  // }
}
