import 'package:flutter/material.dart';
import 'package:graduation_project/models/top_selling_prodcuts.dart';
import '../services/api_service.dart';

class TopSellingProvider with ChangeNotifier {
  List<TopSellingProduct> _products = [];
  bool _isLoading = false;
  String? _error;

  List<TopSellingProduct> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTopSellingProducts(String token) async {
    _isLoading = true;
    _error = null;
    // notifyListeners();

    try {
      _products = await ApiService().fetchTopSellingProducts(token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
