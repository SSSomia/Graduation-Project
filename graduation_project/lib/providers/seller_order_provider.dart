import 'package:flutter/material.dart';
import '../models/seller_order.dart';
import '../services/api_service.dart';

class SellerOrdersProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<SellerOrder> _orders = [];
  bool _isLoading = false;

  List<SellerOrder> get orders => _orders;
  bool get isLoading => _isLoading;

  Future<void> loadOrders(String token, int statusCode) async {
    _isLoading = true;

    try {
      _orders = await _apiService.fetchOrdersByStatus(
        statusCode: statusCode,
        token: token,
      );
    } catch (e) {
      _orders = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
