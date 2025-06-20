import 'package:flutter/material.dart';
import 'package:graduation_project/services/api_service.dart';

class PromoCodeProvider with ChangeNotifier {
// {"message":""","discountPercentage":10.00,"totalBefore":30.00,"totalAfter":27.0000,"discountedProducts":[{"name":"flower1","quantity":3,"originalPrice":10.00,"discountedPrice":9.0000,"subtotal":27.0000}]}
  double? _discountPercentage;
  String? _message;
  String? get message => _message;
  double? get discountPercentage => _discountPercentage;

  Map<String, dynamic>? result;

  Future<void> applyPromo(String promoCode, String token) async {
     result = await ApiService.applyPromoCode(
      promoCode: promoCode,
      token: token,
    );
    if (result != null) {
      _message = result?['message'];
      _discountPercentage = result?['discountPercentage'];
    }
    notifyListeners();
  }
}
