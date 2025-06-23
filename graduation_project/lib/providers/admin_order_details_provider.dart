import 'package:flutter/material.dart';
import 'package:graduation_project/models/admin_order_model_details.dart';
import 'package:graduation_project/services/api_service.dart';
class AdminOrderDetailsProvider extends ChangeNotifier {
  List<AdminOrderDetailsModel> _orders = [];
  bool _isLoading = false;

  List<AdminOrderDetailsModel> get orders => _orders;
  bool get isLoading => _isLoading;

  Future<void> loadOrders(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      _orders = await ApiService.fetchAdminOrders(token);
      print("true");
    } catch (e) {
      print(e);
      _orders = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
