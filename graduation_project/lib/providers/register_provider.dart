import 'package:flutter/material.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/services/api_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String _token = '';
  bool _isAuthenticated = false;

  String get token => _token;
  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;

  Future<String?> register({required User user}) async {
    final result = await ApiService().register(user: user);

    if (result != null && result.containsKey('token')) {
      _token = result['token'];
      _isAuthenticated = true;
      notifyListeners();
      return null;
    } else {
      return result?['message'] ?? 'Registration failed';
      // Handle registration failure
    }
  }

  void logout() {
    _user = null;
    _token = "";
    _isAuthenticated = false;
    notifyListeners();
  }
}
