import 'package:flutter/material.dart';
import 'package:graduation_project/models/seller_order_product.dart';
import '../services/api_service.dart';

class OrderProductsProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<OrderProduct> _products = [];
  bool _isLoading = false;

  List<OrderProduct> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> loadProducts(String token, int orderId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _products =
          await _apiService.fetchOrderProducts(orderId: orderId, token: token);
    } catch (e) {
      _products = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateOrderStatus(
      int orderId, int newStatus, String token) async {
    try {
      final success = await _apiService.updateSellerProductOrderStatus(
        orderId: orderId,
        newStatus: newStatus,
        token: token,
      );

      if (success) {
        // Optionally refetch or notify
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
