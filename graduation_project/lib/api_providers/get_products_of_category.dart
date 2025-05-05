import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/product_module.dart';
import 'package:graduation_project/services/api_service.dart';
import '../models/product.dart';

class CategoryProductProvider with ChangeNotifier {
  List<ProductModule> _products = [];
  bool _isLoading = false;

  List<ProductModule> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> loadProductsByCategory(int categoryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await ApiService.fetchProductsByCategory(categoryId);
    } catch (e) {
      print('Error loading products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
