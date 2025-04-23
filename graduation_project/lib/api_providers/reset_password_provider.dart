import 'package:flutter/material.dart';
import 'package:graduation_project/services/api_service.dart';

class ResetPasswordProvider with ChangeNotifier {
  String _token = "";
  bool _isAuthenticated = false;

  String get token => _token;
  bool get isAuthenticated => _isAuthenticated;

  // Login method
  Future<void> resetPassword(
      String email, String token0, String password) async {
    // Call the API to authenticate the user
    final result = await ApiService().resetPassword(email, token0, password);
    _isAuthenticated = true;
    notifyListeners(); // Notify listeners (UI) that the state has changed
    // if (result != null && result.containsKey('token')) {
    //   _token = result['token'];
    //   _isAuthenticated = true;
    // }
  }
}
