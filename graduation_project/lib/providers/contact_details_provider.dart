import 'package:flutter/material.dart';
import 'package:graduation_project/models/contact_model.dart';
import 'package:graduation_project/services/api_service.dart';

class ContactDetailProvider with ChangeNotifier {
  ContactMessageDetail? _messageDetail;
  bool _isLoading = false;
  String? _error;

  ContactMessageDetail? get messageDetail => _messageDetail;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMessageDetails(String token, int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final detail = await ApiService.getMessageDetails(token, id);
      _messageDetail = detail;
    } catch (e) {
      _error = 'Failed to load message details';
    }

    _isLoading = false;
    notifyListeners();
  }
}
