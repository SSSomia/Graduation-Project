import 'package:flutter/material.dart';
import 'package:graduation_project/services/api_service.dart';

class PromoCodeProvider with ChangeNotifier {
  String? _promoResponse;
  String? get promoResponse => _promoResponse;

  Future<void> applyPromo(String promoCode, String token) async {
    _promoResponse = null;

    final result = await ApiService.applyPromoCode(
      promoCode: promoCode,
      token: token,
    );
    _promoResponse = result;
print('*********************'+ promoResponse!);
    notifyListeners();
  }
}
