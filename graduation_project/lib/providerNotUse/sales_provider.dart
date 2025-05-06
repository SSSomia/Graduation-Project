import 'package:flutter/material.dart';

class SalesProvider with ChangeNotifier {
  double totalRevenue = 24500.75;
  int totalOrders = 150;
  int completedOrders = 120;
  int pendingOrders = 20;
  int canceledOrders = 10;

  List<Map<String, dynamic>> salesData = [
    {"month": "Jan", "revenue": 8000},
    {"month": "Feb", "revenue": 9000},
    {"month": "Mar", "revenue": 10000},
    {"month": "Apr", "revenue": 7500},
    {"month": "May", "revenue": 9500},
  ];

  Map<String, double> orderBreakdown() {
    return {
      "Completed": completedOrders.toDouble(),
      "Pending": pendingOrders.toDouble(),
      "Canceled": canceledOrders.toDouble(),
    };
  }
}
