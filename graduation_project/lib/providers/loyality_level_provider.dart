import 'package:flutter/material.dart';
import 'package:graduation_project/models/loyality_level_model.dart';
import 'package:graduation_project/models/loyality_level_model_update.dart';
import 'package:graduation_project/services/api_service.dart';

// class LoyaltyLevelProvider with ChangeNotifier {
//   List<LoyaltyLevel> _levels = [];
//   bool _isLoading = false;
//   String? _error;

//   List<LoyaltyLevel> get levels => _levels;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> fetchLoyaltyLevels(String token) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _levels = await ApiService.fetchLoyaltyLevels(token);
//     } catch (e) {
//       _error = e.toString();
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<bool> updateLoyaltyLevels(String token, LoyaltyLevelUpdate level) async {
//     _isLoading = true;
//     notifyListeners();

//     final success = await ApiService.updateLoyaltyLevels(token, level);

//     _isLoading = false;
//     notifyListeners();

//     return success;
//   }
// }

class LoyaltyLevelProvider with ChangeNotifier {
  List<LoyaltyLevel> _levels = [];
  bool _isLoading = false;
  String? _error;

  List<LoyaltyLevel> get levels => _levels;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchLoyaltyLevels(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _levels = await ApiService.fetchLoyaltyLevels(token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateLoyaltyLevels(
      String token, LoyaltyLevelUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();

    final success = await ApiService.updateLoyaltyLevels(token, request);

    _isLoading = false;
    notifyListeners();

    return success;
  }
}
