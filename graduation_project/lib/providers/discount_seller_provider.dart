import 'package:flutter/material.dart';
import 'package:graduation_project/models/dicount_seller_model.dart';
import '../services/api_service.dart';

class DiscountProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> sendDiscount({
    required Discount discount,
    required String token,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    if (discount.couponCode.isEmpty) {
      print("Coupon code is empty!");
    }

    final success =
        await ApiService().sendDiscount(discount: discount, token: token);

    _isLoading = false;
    if (!success) {
      _errorMessage = "Failed to send discount.";
    } else
      print("true");
    notifyListeners();
    return success;
  }
}
