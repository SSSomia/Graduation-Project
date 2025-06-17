import 'package:flutter/material.dart';
import 'package:graduation_project/models/track_order.dart';
import '../services/api_service.dart';

class TrackOrderProvider with ChangeNotifier {
  TrackOrderModel? _trackOrder;
  String? _error;

  TrackOrderModel? get trackOrder => _trackOrder;
  String? get error => _error;

  Future<void> fetchTrackOrder(int orderId, String token) async {
    try {
      _error = null;
      final data = await ApiService().getTrackOrder(orderId, token);
      _trackOrder = TrackOrderModel.fromJson(data);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}
