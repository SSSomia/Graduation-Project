import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/order_model.dart';
import 'package:graduation_project/services/api_service.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUserOrders(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orders = await ApiService.fetchUserOrders(token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
