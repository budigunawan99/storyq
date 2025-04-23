import 'package:storyq/data/model/session.dart';

class LoginResponse {
  final bool error;
  final String message;
  final Session loginResult;

  LoginResponse({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      error: json["error"],
      message: json["message"],
      loginResult: Session.fromJson(json["loginResult"]),
    );
  }
}
