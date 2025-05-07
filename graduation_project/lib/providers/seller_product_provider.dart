import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/product_module.dart';
import 'package:graduation_project/models/seller_product.dart';
import 'package:graduation_project/services/api_service.dart';

class SellerProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool isLoading = false;

  Future<Map<String, dynamic>> addProduct({
    required String token,
    required SellerProduct product,
    required List<File> images,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.addProduct(
        token: token,
        product: product,
        images: images,
      );
      return response;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<ProductModule> _products = [];

  List<ProductModule> get products => _products;

  Future<void> fetchMyProducts(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchMyProducts(token);
    } catch (e) {
      // Handle error if necessary
      print("Error fetching products: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
