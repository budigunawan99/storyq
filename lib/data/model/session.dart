import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.g.dart';
part 'session.freezed.dart';

@freezed
abstract class Session with _$Session {
  const factory Session({String? userId, String? name, String? token}) =
      _Session;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
