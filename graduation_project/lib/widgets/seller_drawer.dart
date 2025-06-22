import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/notification_provider.dart';
import 'package:graduation_project/providers/profile_provider.dart';
import 'package:graduation_project/screens/customer/about.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:graduation_project/screens/customer/contact_us.dart';
import 'package:graduation_project/screens/customer/orders/orders.dart';
import 'package:graduation_project/screens/customer/profile/edit_profile_data.dart';
import 'package:graduation_project/screens/customer/favorite_page.dart';
import 'package:graduation_project/screens/customer/notifications/notification_screen.dart';
import 'package:graduation_project/screens/customer/settings_screen.dart';
import 'package:graduation_project/screens/seller/coupon_screen.dart';
import 'package:graduation_project/screens/seller/orders/seller_orders_page.dart';
import 'package:graduation_project/screens/seller/profit_summary_screen.dart';
import 'package:provider/provider.dart';

class SellerDrawer extends StatefulWidget {
  const SellerDrawer({super.key});

  @override
  State<SellerDrawer> createState() => _SellerDrawerState();
}

class _SellerDrawerState extends State<SellerDrawer> {
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
              color: Color.fromARGB(255, 167, 25, 25),
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileData()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.library_books_outlined),
          title: const Text('Orders'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SellerOrdersPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.discount_outlined),
          title: const Text('Coupons'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SellerCouponsPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_balance_wallet_outlined),
          title: const Text('Profit'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfitSummaryScreen()));
          },
        ),
        Consumer<NotificationProvider>(
          builder: (context, notificationProvider, _) {
            int count = notificationProvider.unreadCount;
            return ListTile(
              leading: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications_outlined, size: 28),
                  if (count > 0)
                    Positioned(
                      top: -4,
                      right: -6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()),
                );
              },
            );
          },
        ),

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
        ListTile(
          leading: const Icon(Icons.info_outline_rounded),
          title: const Text('About Us'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutPage()));
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
