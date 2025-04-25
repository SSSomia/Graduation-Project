import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/product_module.dart';
import 'package:graduation_project/services/api_service.dart';

class ProductProvider with ChangeNotifier {
  ProductModule? _product;
  bool _isLoading = false;
  String? _error;

  ProductModule? get product => _product;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch product by ID
  Future<void> fetchProductById(String token, int productId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _product = await ApiService.fetchProductById(token, productId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
