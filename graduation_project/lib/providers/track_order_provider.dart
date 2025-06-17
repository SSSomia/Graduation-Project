import 'package:flutter/material.dart';
import 'package:graduation_project/models/track_order.dart';
import 'package:graduation_project/services/api_service.dart';

class TrackingProvider with ChangeNotifier {
  TrackingModel? trackingData;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadTracking(int orderId, String token) async {
    isLoading = true;
    notifyListeners();

    try {
      trackingData = await ApiService.fetchTracking(orderId, token);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
