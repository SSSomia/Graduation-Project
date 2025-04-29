import 'package:flutter/material.dart';
import 'package:graduation_project/api_providers/cart_provider.dart';
import 'package:graduation_project/api_providers/change_password_provider.dart';
import 'package:graduation_project/api_providers/favorite_provider.dart';
import 'package:graduation_project/api_providers/forget_passwrod_provider.dart';
import 'package:graduation_project/api_providers/login_provider.dart';
import 'package:graduation_project/api_providers/order_details_provider.dart';
import 'package:graduation_project/api_providers/orders_provider.dart';
import 'package:graduation_project/api_providers/product_provider.dart';
import 'package:graduation_project/api_providers/products_provider.dart';
import 'package:graduation_project/api_providers/profile_provider.dart';
import 'package:graduation_project/api_providers/register_provider.dart';
import 'package:graduation_project/api_providers/reset_password_provider.dart';
import 'package:graduation_project/api_providers/update_profile_data.dart';
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
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:graduation_project/screens/product/productPage.dart';
import 'package:graduation_project/semiAPIcall/get_request.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    // ChangeNotifierProvider(create: (_) => CartList()),
    ChangeNotifierProvider(create: (_) => FavoriteList()),
    //ChangeNotifierProvider(create: (_) => OrderList()),
    ChangeNotifierProvider(create: (_) => PersonProvider()),
    ChangeNotifierProvider(create: (_) => ProductList()),
    ChangeNotifierProvider(create: (_) => MarketProvider()),
    ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => SalesProvider()),
    ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
    ChangeNotifierProvider(create: (_) => SellersProvider()),
    ChangeNotifierProvider(create: (_) => DataProvider()),
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

    // ChangeNotifierProvider(create: (_) => UpdateProfileData()),
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
      home: LoginPage(),
    );
  }
}
