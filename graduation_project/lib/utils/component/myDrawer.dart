import 'package:flutter/material.dart';
import 'package:graduation_project/pages/constant.dart';
import 'package:graduation_project/pages/favorite/favorite_page.dart';
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
        ListTile(
            leading: Icon(Icons.account_circle_outlined), // Add an icon here
            title: Text('Account'),
            
          ),
        ListTile(
          leading: Badge.count(
              count: 1, child: const Icon(Icons.notifications_active_outlined)),
          title: const Text('Notification'),
        ),
         ListTile(
            leading: Icon(Icons.favorite_outline_outlined), // Add an icon here
            title: Text('Favorites'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  MyFavorites()));
            },
          ),
        const Divider(
          height: 1,
        ),
         ListTile(
            leading: Icon(Icons.settings_outlined), // Add an icon here
            title: Text('Settings'),
            
          ),
        ListTile(
            leading: Icon(Icons.logout_rounded), // Add an icon here
            title: Text('Logout'),
            
          ),
      ],
    );
  }
}
