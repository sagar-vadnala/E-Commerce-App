// models/user.dart
class User {
  final String id;
  final String token;

  User({required this.id, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      token: json['token'],
    );
  }
}
