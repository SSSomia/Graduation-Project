import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/profile_provider.dart';
import 'package:graduation_project/screens/about.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:graduation_project/screens/contact_us.dart';
import 'package:graduation_project/screens/edit_profile_data.dart';
import 'package:graduation_project/screens/favorite_page.dart';
import 'package:graduation_project/screens/settings_screen.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
    // Fetch profile after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.fetchProfile(authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context, listen: false);

    return NavigationDrawer(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      children: <Widget>[
        Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
          final user = profileProvider.userProfile;

          // If user data is null (still loading), show loading indicator
          if (user == null) {
            return const UserAccountsDrawerHeader(
              accountName: Text('Loading...'),
              accountEmail: Text('Loading...'),
              currentAccountPicture: CircularProgressIndicator(),
            );
          }

          // Once user data is available, show the profile information
          return UserAccountsDrawerHeader(
            accountName: Text(
              user.UserName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 57, 149, 159),
            ),
            accountEmail: Text(
              user.email,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: const Icon(
              Icons.shopping_bag_outlined,
              size: 60,
              color: Colors.white,
            ),
          );
        }),
        ListTile(
          leading: const Icon(Icons.account_circle_outlined),
          title: const Text('Account'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfileData()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite_outline_outlined),
          title: const Text('Favorites'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyFavorites()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsPage()));
          },
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.info_outline_rounded),
          title: const Text('About Us'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.contact_support_outlined),
          title: const Text('Contact Us'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ContactUsPage()));
          },
        ),
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
