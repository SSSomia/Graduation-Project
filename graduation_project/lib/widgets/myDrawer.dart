import 'package:flutter/material.dart';
import 'package:graduation_project/not%20used/constant.dart';
import 'package:graduation_project/screens/about.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:graduation_project/screens/contact_us.dart';
import 'package:graduation_project/screens/edit_profile_data.dart';
import 'package:graduation_project/screens/favorite_page.dart';
import 'package:graduation_project/not%20used/utils/listTileDrawer.dart';
import 'package:graduation_project/screens/home_page.dart';
import 'package:graduation_project/screens/profile_page.dart';
import 'package:graduation_project/screens/settings_screen.dart';

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
          leading:
              const Icon(Icons.account_circle_outlined), // Add an icon here
          title: const Text('Account'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfileData()));
          },
        ),
        ListTile(
          leading:
              const Icon(Icons.favorite_outline_outlined), // Add an icon here
          title: const Text('Favorites'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyFavorites()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined), // Add an icon here
          title: const Text('Settings'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsPage()));
          },
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: const Icon(Icons.info_outline_rounded), // Add an icon here
          title: const Text('About Us'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutPage()));
          },
        ),
        ListTile(
          leading:
              const Icon(Icons.contact_support_outlined), // Add an icon here
          title: const Text('Contact Us'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ContactUsPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout_rounded), // Add an icon here
          title: const Text('Logout'),
          onTap: () {
            // Handle logout action
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
