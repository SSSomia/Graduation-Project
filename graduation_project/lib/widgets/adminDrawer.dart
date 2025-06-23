import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/notification_provider.dart';
import 'package:graduation_project/providers/profile_provider.dart';
import 'package:graduation_project/screens/customer/about.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:graduation_project/screens/customer/category_screen.dart';
import 'package:graduation_project/screens/customer/contact_us.dart';
import 'package:graduation_project/screens/customer/orders/orders.dart';
import 'package:graduation_project/screens/customer/profile/edit_profile_data.dart';
import 'package:graduation_project/screens/customer/favorite_page.dart';
import 'package:graduation_project/screens/customer/notifications/notification_screen.dart';
import 'package:graduation_project/screens/customer/settings_screen.dart';
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
        // ListTile(
        //   leading: const Icon(Icons.account_circle_outlined),
        //   title: const Text('Account'),
        //   onTap: () {
        //     Navigator.pop(context);
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => const EditProfileData()));
        //   },
        // ),
        // ListTile(
        //   leading: const Icon(Icons.category_outlined),
        //   title: const Text('Categories'),
        //   onTap: () {
        //     Navigator.pop(context);
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => const CategoriesPage()));
        //   },
        // ),
        ListTile(
          leading: const Icon(Icons.favorite_outline_outlined),
          title: const Text('Pending Sellers'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyFavorites()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.library_books_outlined),
          title: const Text('Approved Sellers'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Orders()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.library_books_outlined),
          title: const Text('Messages'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Orders()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.library_books_outlined),
          title: const Text('Orders Overview'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Orders()));
          },
        ),
        // Consumer<NotificationProvider>(
        //   builder: (context, notificationProvider, _) {
        //     int count = notificationProvider.unreadCount;
        //     return ListTile(
        //       leading: Stack(
        //         clipBehavior: Clip.none,
        //         children: [
        //           const Icon(Icons.notifications_outlined, size: 28),
        //           if (count > 0)
        //             Positioned(
        //               top: -4,
        //               right: -6,
        //               child: Container(
        //                 padding: const EdgeInsets.symmetric(
        //                     horizontal: 6, vertical: 2),
        //                 decoration: BoxDecoration(
        //                   color: Colors.redAccent,
        //                   borderRadius: BorderRadius.circular(12),
        //                   border: Border.all(color: Colors.white, width: 1),
        //                 ),
        //                 child: Text(
        //                   '$count',
        //                   style: const TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 11,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //         ],
        //       ),
        //       title: const Text('Notifications'),
        //       onTap: () {
        //         Navigator.pop(context);
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => const NotificationScreen()),
        //         );
        //       },
        //     );
        //   },
        // ),

        // ListTile(
        //   leading: Stack(
        //     clipBehavior: Clip.none,
        //     children: [
        //       const Icon(Icons.notifications_outlined, size: 28),
        //       if (count > 0)
        //         Positioned(
        //           top: -4,
        //           right: -6,
        //           child: Container(
        //             padding:
        //                 const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        //             decoration: BoxDecoration(
        //               color: Colors.redAccent,
        //               borderRadius: BorderRadius.circular(12),
        //               border: Border.all(color: Colors.white, width: 1),
        //             ),
        //             child: Text(
        //               '$count',
        //               style: const TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 11,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ),
        //         ),
        //     ],
        //   ),
        //   title: const Text('Notifications'),
        //   onTap: () {
        //     Navigator.pop(context);
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => const NotificationScreen()));

        //     // Navigate to notifications page
        //   },
        // ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsPage()));
          },
        ),
        // ListTile(
        //   leading: const Icon(Icons.info_outline_rounded),
        //   title: const Text('About Us'),
        //   onTap: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => const AboutPage()));
        //   },
        // ),
        // ListTile(
        //   leading: const Icon(Icons.contact_support_outlined),
        //   title: const Text('Contact Us'),
        //   onTap: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => const ContactUsPage()));
        //   },
        // ),
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
