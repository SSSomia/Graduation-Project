import 'package:flutter/material.dart';
import 'package:graduation_project/screens/dashboard/analytics_screen.dart';
import 'package:graduation_project/screens/market_product_screen.dart';
import 'orders_screen.dart';

class SellerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seller Dashboard")),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCard("Orders", Icons.list, () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrdersScreen()))),
          _buildCard("Products", Icons.shop, () => Navigator.push(context, MaterialPageRoute(builder: (_) => MarketProductScreen()))),
          _buildCard("Analytics", Icons.analytics_outlined, () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnalyticsScreen()))),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon, size: 40), SizedBox(height: 10), Text(title)],
        ),
      ),
    );
  }
}
