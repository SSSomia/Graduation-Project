import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/product_module.dart';
import 'package:graduation_project/models/product.dart';
import 'package:graduation_project/services/api_service.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModule> _products = [];
  bool _isLoading = false;
  String? _error;

  List<ProductModule> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRandomProducts(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await ApiService.fetchRandomProductss(token);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
