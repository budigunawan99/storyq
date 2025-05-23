import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({String? name, String? email, String? password}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
