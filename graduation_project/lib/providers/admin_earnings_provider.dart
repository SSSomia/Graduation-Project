import 'package:flutter/material.dart';
import 'package:graduation_project/models/plateform_earnings_model.dart';
import 'package:graduation_project/services/api_service.dart';

class AdminEarningsProvider with ChangeNotifier {
  List<PlatformEarningsReport> _reports = [];
  bool _isLoading = false;
  String? _error;

  List<PlatformEarningsReport> get reports => _reports;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchReports(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _reports = await ApiService.fetchReports(token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
