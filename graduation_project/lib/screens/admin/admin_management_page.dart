import 'package:flutter/material.dart';
import 'package:graduation_project/modelNotUse/copoun_model_test.dart';
import 'package:graduation_project/screens/admin/admin_coupons.dart';
import 'package:graduation_project/screens/admin/admin_messages_screen.dart';
import 'package:graduation_project/screens/admin/admin_order_details_screen.dart';
import 'package:graduation_project/screens/admin/approved_seller.dart';
import 'package:graduation_project/screens/admin/seller_requests_screen.dart';
import 'package:graduation_project/screens/seller/addCoupon.dart';
import 'package:graduation_project/widgets/adminDrawer.dart';

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
        backgroundColor: const Color.fromARGB(255, 173, 26, 26),
        indicatorColor: const Color.fromARGB(255, 255, 255, 255),
        selectedIndex: currentPageIndex,
        animationDuration: Durations.extralong4,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.pending_actions_outlined),
            label: 'Pending Sellers',
          ),
          // NavigationDestination(
          //   icon: Icon(Icons.list_alt_sharp),
          //   label: 'Approved Seller',
          // ),
          // NavigationDestination(
          //   icon: Icon(Icons.message_outlined),
          //   label: 'Messages',
          // ),
          NavigationDestination(
            icon: Icon(Icons.list_outlined),
            label: 'Orders',
          ),
        ],
      ),
      body: <Widget>[
        SellerRequestsPage(),
        // ApprovedSellers(),
        // AdminMessagesScreen(),
        AdminOrderDetailsScreen()
      ][currentPageIndex],
    );
  }
}
