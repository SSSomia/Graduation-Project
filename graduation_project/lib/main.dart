import 'package:flutter/material.dart';
import 'package:graduation_project/providers/cart_list.dart';
import 'package:graduation_project/providers/favorite_list.dart';
import 'package:graduation_project/providers/order_list.dart';
import 'package:graduation_project/product_list/product_list.dart';
import 'package:graduation_project/providers/person_provider.dart';
import 'package:graduation_project/providers/analytics_provider.dart';
import 'package:graduation_project/providers/market_provider.dart';
import 'package:graduation_project/providers/prodcut_provider.dart';
import 'package:graduation_project/providers/sales_provider.dart';
import 'package:graduation_project/providers/sellers_provider.dart';
import 'package:graduation_project/screens/auth/signup_page.dart';
import 'package:graduation_project/screens/onboarding/onboarding_screens.dart';
import 'package:graduation_project/screens/seller_requests_screen.dart';
import 'package:graduation_project/screens/without_login/home_page_wihoutLogin.dart';
import 'package:graduation_project/semiAPIcall/get_request.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CartList()),
    ChangeNotifierProvider(create: (_) => FavoriteList()),
    ChangeNotifierProvider(create: (_) => OrderList()),
    ChangeNotifierProvider(create: (_) => PersonProvider()),
    ChangeNotifierProvider(create: (_) => ProductList()),
    ChangeNotifierProvider(create: (_) => MarketProvider()),
    ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => SalesProvider()),
    ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
    ChangeNotifierProvider(create: (_) => SellersProvider()),
    ChangeNotifierProvider(create: (_) => DataProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   title: 'Graduation project',
    //   home: SignupPage(),
    // );
    // return MaterialApp(
    //   title: 'Seller App',
    //   theme: ThemeData(primarySwatch: Colors.blue),
    //   home: OnboardingScreen(),
    // );
    return MaterialApp(
      // have to make it in the real app appear just once !!!!!
      home: HomePageWihoutlogin(),
    );
  }
}
