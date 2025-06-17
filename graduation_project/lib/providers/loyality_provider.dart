import 'package:flutter/material.dart';
import 'package:graduation_project/models/loyality_status.dart';
import 'package:graduation_project/services/api_service.dart';

class LoyaltyProvider with ChangeNotifier {
  LoyaltyStatusModel? _loyaltyStatus;
  LoyaltyStatusModel? get loyaltyStatus => _loyaltyStatus;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadLoyaltyStatus(String token) async {
    _isLoading = true;

    final result = await ApiService.fetchLoyaltyStatus(token);
    _loyaltyStatus = result;
    _isLoading = false;
    notifyListeners();
  }
}
