import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/store_info_model.dart';
import 'package:graduation_project/services/api_service.dart';

class StoreProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _message;

  bool get isLoading => _isLoading;
  String? get message => _message;

  Future<void> submitStore(StoreModel store, String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      _message = await ApiService.submitStoreInfo(store, token);
    } catch (e) {
      _message = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
