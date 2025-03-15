import 'package:flutter/material.dart';
import 'package:graduation_project/pages/you/you.dart';
import 'package:graduation_project/screens/dashboard/analytics_screen.dart';
import 'package:graduation_project/screens/market_product_screen.dart';
import 'package:graduation_project/screens/seller_main_page.dart';
import 'orders_screen.dart';

class SellerHomeScreen extends StatefulWidget {
  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  int currentPageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shoopy',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.shopping_bag_outlined),
        backgroundColor: const Color.fromARGB(255, 244, 255, 254),
        //  shadowColor: const Color.fromARGB(255, 252, 252, 252),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: const Color.fromARGB(255, 82, 157, 165),
        indicatorColor: const Color.fromARGB(255, 255, 255, 255),
        selectedIndex: currentPageIndex,
        animationDuration: Durations.extralong4,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            label: 'You',
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
         
        ],
      ),
      body: <Widget>[
        const You(),
        const SellerMainPage(),
      ][currentPageIndex],
    );
  }
}
