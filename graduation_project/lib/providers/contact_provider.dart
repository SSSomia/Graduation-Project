import 'package:flutter/material.dart';
import 'package:graduation_project/models/message_model.dart';
import 'package:graduation_project/services/api_service.dart';

class ContactProvider with ChangeNotifier {
  bool _isSending = false;
  String? _responseMessage;

  bool get isSending => _isSending;
  String? get responseMessage => _responseMessage;

  Future<void> sendMessage(String token, String subject, String message) async {
    _isSending = true;
    notifyListeners();

    final response =
        await ApiService.sendContactMessage(token, subject, message);
    _responseMessage = response;

    _isSending = false;
    notifyListeners();
  }

  List<MessageModel> _messages = [];
  bool _isLoading = false;
  String? _error;

  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadMessages(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _messages = await ApiService.fetchMyMessages(token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
