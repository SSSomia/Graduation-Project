import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ChangePasswordProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _success = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get success => _success;

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _success = false;
    notifyListeners();

    final result = await ApiService.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      token: token,
    );

    if (result) {
      _success = true;
      _isLoading = false;
      notifyListeners();
      return "Password changed succesfully";
    }
    return "Failed to change password. Please check your old password.";
  }
}
