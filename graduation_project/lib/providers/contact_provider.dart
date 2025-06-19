import 'package:flutter/material.dart';
import 'package:graduation_project/services/api_service.dart';

class ContactProvider with ChangeNotifier {
  bool _isSending = false;
  String? _responseMessage;

  bool get isSending => _isSending;
  String? get responseMessage => _responseMessage;

  Future<void> sendMessage(String token, String subject, String message) async {
    _isSending = true;
    notifyListeners();

    final response = await ApiService.sendContactMessage(token, subject, message);
    _responseMessage = response;

    _isSending = false;
    notifyListeners();
  }
}
