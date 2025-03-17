import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/signup/signup_page.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/favorite/favorite_list.dart';
import 'package:graduation_project/pages/orders/order_list.dart';
import 'package:graduation_project/pages/product_page/product_list.dart';
import 'package:graduation_project/pages/profile/person_provider.dart';
import 'package:graduation_project/providers/analytics_provider.dart';
import 'package:graduation_project/providers/market_provider.dart';
import 'package:graduation_project/providers/prodcut_provider.dart';
import 'package:graduation_project/providers/sales_provider.dart';
import 'package:graduation_project/providers/sellers_provider.dart';
import 'package:graduation_project/screens/onboarding/onboarding_screens.dart';
import 'package:graduation_project/semiAPIcall/apiHomeScreen.dart';
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
    ChangeNotifierProvider(create: (context) => SellersProvider()),
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
      home: Apihomescreen(),
    );
  }
}
