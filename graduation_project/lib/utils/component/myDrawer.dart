import 'package:flutter/material.dart';
import 'package:graduation_project/pages/constant.dart';
import 'package:graduation_project/utils/listTileDrawer.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      children: <Widget>[
        const UserAccountsDrawerHeader(
          accountName: Text(
            "Somia Srour",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 57, 149, 159),
          ),
          accountEmail: Text(
            "somiasrour@gmail.com",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          currentAccountPicture: Icon(
            Icons.shopping_bag_outlined,
            size: 60,
            color: Colors.white,
          ),
        ),
        ListTileDrawer(
            icon: const Icon(Icons.account_circle_outlined),
            title: 'My Account'),
        ListTile(
          leading: Badge.count(
              count: 1, child: const Icon(Icons.notifications_active_outlined)),
          title: const Text('Notification'),
        ),
        ListTileDrawer(icon: const Icon(Icons.favorite_outline_rounded), title: 'Favorites'),
        const Divider(
          height: 1,
        ),
        ListTileDrawer(icon: const Icon(Icons.settings_outlined), title: 'Settings'),
        ListTileDrawer(icon: const Icon(Icons.logout_rounded), title: 'Logout'),
      ],
    );
  }
}
