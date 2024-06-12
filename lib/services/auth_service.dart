// services/auth_service.dart
import 'dart:convert';
import 'package:e_commerce_app/models/auth_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String apiUrl = 'https://reqres.in/api/login';

  Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode({
        'username': username,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return User.fromJson(responseData);
    } else {
      return null;
    }
  }
}
