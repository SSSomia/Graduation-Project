import 'package:flutter/material.dart';
import 'package:graduation_project/services/api_service.dart';
import '../models/shipping_model.dart';

class ShippingProvider with ChangeNotifier {
  Shipping? _shipping;
  bool _isLoading = false;
  String? _error;

  Shipping? get shipping => _shipping;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchShipping(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _shipping = await ApiService.getShipping(token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateShippingCost(String token, double newCost) async {
    _isLoading = true;
    notifyListeners();

    try {
      _shipping = await ApiService.updateShipping(token, newCost);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
