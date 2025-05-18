// providerNotUse/copoun_provider_test.dart
import 'package:flutter/material.dart';
import 'package:graduation_project/modelNotUse/copoun_model_test.dart';

class CouponProvider extends ChangeNotifier {
  final List<Coupon> _coupons = [];
  List<Coupon> get coupons => List.unmodifiable(_coupons);

  void addCoupon(Coupon c) {
    _coupons.add(c);
    notifyListeners();
  }

  void deleteCoupon(String id) {
    _coupons.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  void updateCoupon(Coupon updated) {
    final index = _coupons.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      _coupons[index] = updated;
      notifyListeners();
    }
  }
}
