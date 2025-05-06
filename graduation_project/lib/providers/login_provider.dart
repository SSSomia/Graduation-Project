import 'package:flutter/material.dart';
import 'package:graduation_project/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  String _token = "";
  bool _isAuthenticated = false;

  String get token => _token;
  bool get isAuthenticated => _isAuthenticated;

  // Login method
  Future<void> login(String email, String password) async {
    // Call the API to authenticate the user
    final result = await ApiService().login(email, password);
    if (result != null && result.containsKey('token')) {
      _token = result['token'];
      _isAuthenticated = true;
       final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token);
      notifyListeners(); // Notify listeners (UI) that the state has changed
    }
  }
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    notifyListeners();
  }
  // Logout method
  void logout() {
    _token = "";
    _isAuthenticated = false;
    notifyListeners();
  }
}
