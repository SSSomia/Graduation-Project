import 'package:flutter/material.dart';
import 'package:graduation_project/models/frist_order_discount.dart';
import 'package:graduation_project/services/api_service.dart';

class DiscountSettingsProvider with ChangeNotifier {
  DiscountSettings? _settings;
  bool _isLoading = false;
  String? _error;

  DiscountSettings? get settings => _settings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchDiscountSettings(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _settings = await ApiService.getSettings(token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<String?> updateDiscountPercentage(String token, double newValue) async {
    _isLoading = true;
    notifyListeners();

    try {
      final message = await ApiService.updateSettings(token, newValue);
      await fetchDiscountSettings(token); // refresh data
      return message;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
