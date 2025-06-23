import 'package:flutter/material.dart';
import 'package:graduation_project/models/order_fee_model.dart';
import 'package:graduation_project/services/api_service.dart';

class OrderFeesProvider with ChangeNotifier {
  OrderFeesModel? _fees;
  bool _isLoading = false;

  OrderFeesModel? get fees => _fees;
  bool get isLoading => _isLoading;

  Future<void> getOrderFees(int orderId, String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      _fees = await ApiService.fetchOrderFees(orderId, token);
    } catch (e) {
      _fees = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _fees = null;
    notifyListeners();
  }
}
