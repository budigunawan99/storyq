// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_login.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserLogin {

 String? get email; String? get password;
/// Create a copy of UserLogin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserLoginCopyWith<UserLogin> get copyWith => _$UserLoginCopyWithImpl<UserLogin>(this as UserLogin, _$identity);

  /// Serializes this UserLogin to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLogin&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'UserLogin(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $UserLoginCopyWith<$Res>  {
  factory $UserLoginCopyWith(UserLogin value, $Res Function(UserLogin) _then) = _$UserLoginCopyWithImpl;
@useResult
$Res call({
 String? email, String? password
});




}
/// @nodoc
class _$UserLoginCopyWithImpl<$Res>
    implements $UserLoginCopyWith<$Res> {
  _$UserLoginCopyWithImpl(this._self, this._then);

  final UserLogin _self;
  final $Res Function(UserLogin) _then;

/// Create a copy of UserLogin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = freezed,Object? password = freezed,}) {
  return _then(_self.copyWith(
email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UserLogin implements UserLogin {
  const _UserLogin({this.email, this.password});
  factory _UserLogin.fromJson(Map<String, dynamic> json) => _$UserLoginFromJson(json);

@override final  String? email;
@override final  String? password;

/// Create a copy of UserLogin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserLoginCopyWith<_UserLogin> get copyWith => __$UserLoginCopyWithImpl<_UserLogin>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserLoginToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserLogin&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'UserLogin(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$UserLoginCopyWith<$Res> implements $UserLoginCopyWith<$Res> {
  factory _$UserLoginCopyWith(_UserLogin value, $Res Function(_UserLogin) _then) = __$UserLoginCopyWithImpl;
@override @useResult
$Res call({
 String? email, String? password
});




}
/// @nodoc
class __$UserLoginCopyWithImpl<$Res>
    implements _$UserLoginCopyWith<$Res> {
  __$UserLoginCopyWithImpl(this._self, this._then);

  final _UserLogin _self;
  final $Res Function(_UserLogin) _then;

/// Create a copy of UserLogin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = freezed,Object? password = freezed,}) {
  return _then(_UserLogin(
email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
