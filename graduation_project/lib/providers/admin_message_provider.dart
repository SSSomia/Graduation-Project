import 'package:flutter/material.dart';
import 'package:graduation_project/models/admin_message_details.dart';
import 'package:graduation_project/services/api_service.dart';
import '../models/admin_message_model.dart';

class AdminMessageProvider extends ChangeNotifier {
  List<AdminMessage> unreadMessages = [];
  List<AdminMessage> readMessages = [];
  bool isLoading = false;
  String? error;

  Future<void> loadAdminMessages(String token) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await ApiService.fetchAdminMessages(token);
      unreadMessages = result['unread']!;
      readMessages = result['read']!;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  AdminMessageDetail? detail;

  Future<void> fetchDetail(String token, int id) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      detail = await ApiService.fetchAdminMessageDetail(token, id);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> sendReply(String token, int messageId, String reply) async {
    try {
      await ApiService.sendAdminReply(token, messageId, reply);
      await fetchDetail(token, messageId); // Refresh after reply
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
