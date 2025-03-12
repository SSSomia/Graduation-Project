import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/login/login_page.dart';
import 'package:graduation_project/pages/auth/signup/signup_page.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/favorite/favorite_list.dart';
import 'package:graduation_project/pages/home/home_page.dart';
import 'package:graduation_project/pages/main_page/mainPage.dart';
import 'package:graduation_project/pages/orders/order_list.dart';
import 'package:graduation_project/pages/product_page/product_list.dart';
import 'package:graduation_project/pages/profile/person_provider.dart';
import 'package:graduation_project/providers/market_provider.dart';
import 'package:graduation_project/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CartList()),
    ChangeNotifierProvider(create: (_) => FavoriteList()),
    ChangeNotifierProvider(create: (_) => OrderList()),
    ChangeNotifierProvider(create: (_) => PersonProvider()),
    ChangeNotifierProvider(create: (_) => ProductList()),
    ChangeNotifierProvider(create: (_) => MarketProvider())
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
    return MaterialApp(
      title: 'Seller App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
