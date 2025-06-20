import 'package:flutter/material.dart';
import 'package:graduation_project/models/product_module.dart';
import 'package:graduation_project/services/api_service.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModule> _products = [];
  bool _isLoading = false;
  String? _error;
  List<ProductModule> newProducts = [];

  List<ProductModule> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Future<void> fetchRandomProducts(String token) async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     _products = await ApiService.fetchRandomProductss(token);
  //   } catch (e) {
  //     _error = e.toString();
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> fetchRandomProducts(String token, {bool append = false}) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      newProducts =
          await ApiService.fetchRandomProductss(token); // Your API logic

      if (append) {
        _products.addAll(newProducts); // ADD instead of REPLACE
      } else {
        _products = newProducts;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
