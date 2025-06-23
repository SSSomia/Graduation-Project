import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/notification_provider.dart';
import 'package:graduation_project/providers/profile_provider.dart';
import 'package:graduation_project/screens/admin/admin_messages_screen.dart';
import 'package:graduation_project/screens/admin/approved_seller.dart';
import 'package:graduation_project/screens/admin/first_order_dicount_screen.dart';
import 'package:graduation_project/screens/admin/loyality_level_screen.dart';
import 'package:graduation_project/screens/admin/shipping_screen.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:graduation_project/screens/customer/orders/orders.dart';
import 'package:provider/provider.dart';

class Admindrawer extends StatefulWidget {
  const Admindrawer({super.key});

  @override
  State<Admindrawer> createState() => _AdmindrawerState();
}

class _AdmindrawerState extends State<Admindrawer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final notificationProvider =
          Provider.of<NotificationProvider>(context, listen: false);

      await profileProvider.fetchProfile(authProvider.token);
      await notificationProvider.fetchUnreadCount(authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    int count = Provider.of<NotificationProvider>(context).unreadCount;
    return NavigationDrawer(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      children: <Widget>[
        const UserAccountsDrawerHeader(
          accountName: Text(
            "Somia Mohammed",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 174, 35, 35),
          ),
          accountEmail: Text(
            "somiasrour@gmail.com",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          currentAccountPicture: Icon(
            Icons.shopping_bag_outlined,
            size: 60,
            color: Colors.white,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.pending_actions_outlined),
          title: const Text('Approved Sellers'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ApprovedSellers()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.message_outlined),
          title: const Text('Messages'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminMessagesScreen()));
          },
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.discount_outlined),
          title: const Text('Loyality Dicounts'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoyaltyLevelsScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.local_shipping_outlined),
          title: const Text('Shipping Cost'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ShippingScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.discount_rounded),
          title: const Text('First Order Dicount'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DiscountSettingsScreen()));
          },
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.logout_rounded),
          title: const Text('Logout'),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}
