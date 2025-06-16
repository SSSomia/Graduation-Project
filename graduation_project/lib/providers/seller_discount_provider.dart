import 'package:flutter/material.dart';
import 'package:graduation_project/models/all_seller_discount.dart';
import '../services/api_service.dart';

class SellerDiscountProvider with ChangeNotifier {
  List<SellerDiscount> _discounts = [];
  bool _isLoading = false;

  List<SellerDiscount> get discounts => _discounts;
  bool get isLoading => _isLoading;

  Future<void> fetchDiscounts(String token) async {
    _isLoading = true;

    try {
      final fetchedDiscounts = await ApiService().fetchSellerDiscounts(token);
      _discounts = fetchedDiscounts;
    } catch (e) {
      print('Error fetching discounts: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteDiscount(String token, int discountId) async {
    final success = await ApiService.deleteSellerDiscount(token, discountId);

    if (success) {
      _discounts.removeWhere((discount) => discount.id == discountId);
      notifyListeners();
    }
  }
}
