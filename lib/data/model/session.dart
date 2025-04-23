class Session {
  String? userId;
  String? name;
  String? token;

  Session({this.userId, this.name, this.token});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      userId: json['userId'],
      name: json['name'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'token': token,
  };
}
