import 'package:flutter/material.dart';
import 'package:graduation_project/models/buy_from_cart_response.dart';
import 'package:graduation_project/models/order_model.dart';
import 'package:graduation_project/services/api_service.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUserOrders(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orders = await ApiService.fetchUserOrders(token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> placeOrder({
    required int productId,
    required int quantity,
    required String fullName,
    required String address,
    required String city,
    required String government,
    required String phoneNumber,
    required String token,
    required String couponCode,
    required double finalPrice,
  }) async {
    _isLoading = true;
    notifyListeners();

    final success = await ApiService.placeOrder(
      productId: productId,
      quantity: quantity,
      fullName: fullName,
      address: address,
      city: city,
      government: government,
      phoneNumber: phoneNumber,
      token: token,
    );

    _isLoading = false;
    notifyListeners();

    return true;
  }

  BuyFromCartResponse? orderResponse;

  Future<void> placeOrderFromCart({
    required String token,
    required String fullName,
    required String address,
    required String city,
    required String government,
    required String phoneNumber,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      orderResponse = await ApiService.placeOrderFromCart(
        token: token,
        fullName: fullName,
        address: address,
        city: city,
        government: government,
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      _error = "Something went wrong: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  // Future<void> placeOrderFromCart({
  //   required String fullName,
  //   required String address,
  //   required String city,
  //   required String government,
  //   required String phoneNumber,
  //   required String token,
  // }) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   final response = await ApiService.placeOrderFromCart(
  //     fullName: fullName,
  //     address: address,
  //     city: city,
  //     government: government,
  //     phoneNumber: phoneNumber,
  //     token: token,
  //   );

  //   _isLoading = false;
  //   notifyListeners();
  // }
}
