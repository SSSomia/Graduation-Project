import 'package:flutter/material.dart';

class AnalyticsProvider with ChangeNotifier {
  double totalRevenue = 24500.75;
  int totalOrders = 150;
  int totalCustomers = 75;
  double revenueGrowth = 8.5; // In percentage
  double ordersGrowth = -3.2; // In percentage (negative means decrease)
  double customersGrowth = 5.1;

  List<Map<String, dynamic>> salesData = [
    {"month": "Jan", "sales": 8000},
    {"month": "Feb", "sales": 9000},
    {"month": "Mar", "sales": 10000},
    {"month": "Apr", "sales": 7500},
    {"month": "May", "sales": 9500},
  ];

  List<Map<String, dynamic>> topProducts = [
    {"name": "Product A", "sales": 120},
    {"name": "Product B", "sales": 90},
    {"name": "Product C", "sales": 85},
    {"name": "Product D", "sales": 75},
  ];

  Map<String, double> customerDemographics() {
    return {
      "New Customers": 40,
      "Returning Customers": 35,
    };
  }
}
