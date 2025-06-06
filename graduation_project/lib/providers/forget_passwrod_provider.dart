import 'package:flutter/material.dart';
import 'package:graduation_project/services/api_service.dart';

class ForgetPasswrodProvider with ChangeNotifier {
  String _token = "";
  bool _isAuthenticated = false;

  String get token => _token;
  bool get isAuthenticated => _isAuthenticated;

  // Login method
  Future<void> forgetPassword(String email) async {
    // Call the API to authenticate the user
    final result = await ApiService().forgetPassword(email);
    if (result != null && result.containsKey('token')) {
      _token = result['token'];
      _isAuthenticated = true;
      notifyListeners(); // Notify listeners (UI) that the state has changed
    }
  }
}
