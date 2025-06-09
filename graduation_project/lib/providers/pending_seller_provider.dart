// providers/pending_sellers_provider.dart
import 'package:flutter/material.dart';
import 'package:graduation_project/models/pending_seller.dart';
import 'package:graduation_project/services/api_service.dart';

class AdminProvider with ChangeNotifier {
  final ApiService _service = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<PendingSeller> _pendingSellers = [];
  List<PendingSeller> get pendingSellers => _pendingSellers;

  List<PendingSeller> _approvedSeller = [];
  List<PendingSeller> get approvedSeller => _approvedSeller;

  Future<void> loadPendingSellers(String token) async {
    _isLoading = true;
    _pendingSellers = await _service.fetchPendingSellers(token);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadApprovedSellers(String token) async {
    _isLoading = true;
    _approvedSeller = await _service.getApprovedSellers(token);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> approveSeller(
      {required int userId, required String token}) async {
    try {
      await ApiService().approveSeller(userId, token);

      // Update the local list
      final index =
          pendingSellers.indexWhere((seller) => seller.userId == userId);
      if (index != -1) {
        pendingSellers[index].status = 'accepted';
        notifyListeners();
      }
    } catch (e) {
      throw Exception("Approval failed: $e");
    }
  }

  Future<void> rejectSeller(
      {required int sellerId, required String token}) async {
    try {
      await ApiService().rejectSeller(sellerId, token);

      final index =
          pendingSellers.indexWhere((seller) => seller.userId == sellerId);
      if (index != -1) {
        pendingSellers[index].status = 'rejected';
        notifyListeners();
      }
    } catch (e) {
      throw Exception("Rejection failed: $e");
    }
  }
}
