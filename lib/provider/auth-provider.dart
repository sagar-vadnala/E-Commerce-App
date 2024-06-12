// providers/auth_provider.dart
import 'package:e_commerce_app/models/auth_model.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isAuthenticated = false;
 
  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String username, String password) async {
    AuthService authService = AuthService();
    User? user = await authService.login(username, password);

    if (user != null) {
      _user = user;
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
