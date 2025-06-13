import 'package:flutter/material.dart';
import 'package:graduation_project/models/top_selling_prodcuts.dart';
import 'package:graduation_project/providerNotUse/copoun_provider_test.dart';
import 'package:graduation_project/providers/cart_provider.dart';
import 'package:graduation_project/providers/category_provider.dart';
import 'package:graduation_project/providers/change_password_provider.dart';
import 'package:graduation_project/providers/favorite_provider.dart';
import 'package:graduation_project/providers/forget_passwrod_provider.dart';
import 'package:graduation_project/providers/get_products_of_category.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/notification_provider.dart';
import 'package:graduation_project/providers/order_details_provider.dart';
import 'package:graduation_project/providers/orders_provider.dart';
import 'package:graduation_project/providers/pending_seller_provider.dart';
import 'package:graduation_project/providers/product_provider.dart';
import 'package:graduation_project/providers/products_provider.dart';
import 'package:graduation_project/providers/profile_provider.dart';
import 'package:graduation_project/providers/register_provider.dart';
import 'package:graduation_project/providers/reset_password_provider.dart';
import 'package:graduation_project/providers/review_provider.dart';
import 'package:graduation_project/providers/seller_product_provider.dart';
import 'package:graduation_project/providers/seller_top_selling_prodcuts.dart';
import 'package:graduation_project/providers/store_info_provider.dart';
import 'package:graduation_project/providers/update_profile_data.dart';
import 'package:graduation_project/providerNotUse/analytics_provider.dart';
import 'package:graduation_project/providerNotUse/sales_provider.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => SalesProvider()),
    ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => ForgetPasswrodProvider()),
    ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ChangeNotifierProvider(create: (_) => UpdateProfileData()),
    ChangeNotifierProvider(create: (_) => ProductsProvider()),
    ChangeNotifierProvider(create: (_) => FavoriteProvider()),
    ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    ChangeNotifierProvider(create: (_) => OrderProvider()),
    ChangeNotifierProvider(create: (_) => OrderDetailProvider()),
    ChangeNotifierProvider(create: (_) => StoreProvider()),
    ChangeNotifierProvider(create: (_) => AdminProvider()),
    ChangeNotifierProvider(create: (_) => CategoryProvider()),
    ChangeNotifierProvider(create: (_) => CategoryProductProvider()),
    ChangeNotifierProvider(create: (_) => NotificationProvider()),
    ChangeNotifierProvider(create: (_) => SellerProductProvider()),
    ChangeNotifierProvider(create: (_) => TopSellingProvider()),
    ChangeNotifierProvider(create: (_) => ReviewProvider()),
    // will be removed
    ChangeNotifierProvider(create: (_) => CouponProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Seller App',
    //   theme: ThemeData(primarySwatch: Colors.blue),
    //   home: OnboardingScreen(),
    // );
    return const MaterialApp(
      // have to make it in the real app appear just once !!!!!
      home: LoginPage(),
    );
  }
}
