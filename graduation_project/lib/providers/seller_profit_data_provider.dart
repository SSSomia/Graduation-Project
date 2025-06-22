import 'package:flutter/material.dart';
import 'package:graduation_project/models/seller_profit_data.dart';
import 'package:graduation_project/services/api_service.dart';

class ProfitSummaryProvider with ChangeNotifier {
  ProfitSummaryModel? _profitSummary;
  bool _isLoading = false;

  ProfitSummaryModel? get profitSummary => _profitSummary;
  bool get isLoading => _isLoading;

  Future<void> loadProfitSummary(String token) async {
    _isLoading = true;
    // notifyListeners();

    final data = await ApiService.fetchProfitSummary(token);
    _profitSummary = data;

    _isLoading = false;
    notifyListeners();
  }
}
