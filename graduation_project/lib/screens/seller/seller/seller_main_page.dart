import 'package:flutter/material.dart';
import 'package:graduation_project/screens/customer/contact_us.dart';
import 'package:graduation_project/screens/customer/notifications/notification_screen.dart';
import 'package:graduation_project/screens/seller/coupon_screen.dart';
import 'package:graduation_project/screens/seller/dashboard/analytics_screen.dart';
import 'package:graduation_project/screens/seller/my_buyers.dart';
import 'package:graduation_project/screens/seller/orders/seller_orders_page.dart';
import 'package:graduation_project/screens/seller/product/market_product_screen.dart';

class SellerMainPage extends StatelessWidget {
  const SellerMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCard(
              "Products",
              Icons.shop_outlined,
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MarketProductScreen()))),
          _buildCard(
              "Analytics",
              Icons.analytics_outlined,
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AnalyticsScreen()))),
        ],
      ),
    );
  }
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
