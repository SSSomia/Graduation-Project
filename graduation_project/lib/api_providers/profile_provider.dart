// providers/profile_provider.dart
import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/global_user_model.dart';
import 'package:graduation_project/services/api_service.dart';

class ProfileProvider with ChangeNotifier {
  UserModel? _userProfile;
  bool _isLoading = false;
  String? _error;

  UserModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProfile(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await ApiService().getProfile(token);
      if (result != null) {
        _userProfile = UserModel.fromJson(result);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateProfile(UserModel user) {
    _userProfile = user;
    notifyListeners();
  }

  void clear() {
    _userProfile = null;
    notifyListeners();
  }
}
