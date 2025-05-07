import 'package:flutter/material.dart';
import 'package:graduation_project/models/notification_model.dart';
import 'package:graduation_project/services/api_service.dart';

class NotificationProvider extends ChangeNotifier {
  final ApiService _service = ApiService();

  List<AppNotification> _notifications = [];
  bool _isLoading = false;

  List<AppNotification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int _unreadCount = 0;

  int get unreadCount => _unreadCount;

  Future<void> fetchUnreadCount(String token) async {
    try {
      _unreadCount = await _service.getUnreadNotificationCount(token);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching unread count: $e');
    }
  }

  // Future<void> markNotificationAsRead(String token, int id) async {
  //   try {
  //     await _service.markAsRead(token, id);

  //     // Optionally update local list
  //     final index = _notifications
  //         .indexWhere((n) => n.createdAt.millisecondsSinceEpoch == id);
  //     if (index != -1) {
  //       // No actual "read" status in model, but you could remove or refresh
  //       _notifications.removeAt(index);
  //       notifyListeners();
  //     }

  //     // Refresh unread count
  //     fetchUnreadCount(token);
  //   } catch (e) {
  //     debugPrint('Error marking notification as read: $e');
  //   }
  // }

  Future<void> markNotificationAsRead(String token, int id) async {
    try {
      await _service.markAsRead(token, id);
      //_notifications.removeWhere((n) => n.id == id);
      notifyListeners();
      fetchUnreadCount(token);
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
    }
  }

  Future<void> fetchNotifications(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      _notifications = await ApiService.fetchNotifications(token);
    } catch (e) {
      print("Error fetching notifications: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
