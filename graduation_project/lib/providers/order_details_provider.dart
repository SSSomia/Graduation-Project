import 'package:flutter/material.dart';
import 'package:graduation_project/models/order_details_model.dart';
import 'package:graduation_project/services/api_service.dart';

class OrderDetailProvider with ChangeNotifier {
  List<OrderDetail> _details = [];
  bool _isLoading = false;
  String? _error;

  List<OrderDetail> get details => _details;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadOrderDetails(int orderId, String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _details = await ApiService.fetchOrderDetails(orderId, token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}


// class OrderDetailProvider with ChangeNotifier {
//   final _details;
//   bool _isLoading = false;
//   String? _error;

//   get details => _details;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   get orderDetails => null;

//   Future<void> loadOrderDetails(int orderId, String token) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _details = await ApiService.fetchOrderDetails(orderId, token);
//       print(details['orderDetails']);
//     } catch (e) {
//       _error = e.toString();
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }


// class OrderDetailProvider with ChangeNotifier {
//   OrderDetailsModel? _details;
//   bool _isLoading = false;

//   OrderDetailsModel? get orderDetails => _details;
//   bool get isLoading => _isLoading;

//   Future<void> loadOrderDetails(int orderId) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _details = await ApiService.getOrderDetails(orderId); // Replace with your real API call
//     } catch (e) {
//       debugPrint("Failed to fetch order details: $e");
//       _details = null;
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }


