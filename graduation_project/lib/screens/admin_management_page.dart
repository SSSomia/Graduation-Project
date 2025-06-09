import 'package:flutter/material.dart';
import 'package:graduation_project/screens/admin_coupons.dart';
import 'package:graduation_project/screens/approved_seller.dart';
import 'package:graduation_project/screens/seller_requests_screen.dart';

class AdminManagementPage extends StatefulWidget {
  const AdminManagementPage({super.key});

  @override
  State<AdminManagementPage> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<AdminManagementPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.pending_actions_outlined),
            label: 'Pending Sellers',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_sharp),
            label: 'Approved Seller',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_giftcard),
            label: 'Coupons',
          ),
        ],
      ),
      body: <Widget>[
        SellerRequestsPage(),
        ApprovedSellers(),
        AdminCoupons()
      ][currentPageIndex],
    );
  }
}
