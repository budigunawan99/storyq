import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login.g.dart';
part 'user_login.freezed.dart';

@freezed
abstract class UserLogin with _$UserLogin {
  const factory UserLogin({String? email, String? password}) = _UserLogin;

  factory UserLogin.fromJson(Map<String, dynamic> json) =>
      _$UserLoginFromJson(json);
}
