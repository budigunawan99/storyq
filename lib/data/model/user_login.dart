class UserLogin {
  String? email;
  String? password;

  UserLogin({this.email, this.password});

  @override
  String toString() => 'User(email: $email, password: $password)';

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
