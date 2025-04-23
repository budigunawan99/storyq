class User {
  String? name;
  String? email;
  String? password;

  User({this.name, this.email, this.password});

  @override
  String toString() => 'User(name: $name, email: $email, password: $password)';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
  };
}
