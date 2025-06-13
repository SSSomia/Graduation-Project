import 'package:flutter/material.dart';
import '../models/buyer.dart';
import '../services/api_service.dart';

class BuyersProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Buyer> _buyers = [];
  bool _isLoading = false;

  List<Buyer> get buyers => _buyers;
  bool get isLoading => _isLoading;

  Future<void> loadBuyers(String token) async {
    _isLoading = true;
    try {
      _buyers = await _apiService.fetchMyBuyers(token);
    } catch (e) {
      _buyers = [];
      debugPrint("Error fetching buyers: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
