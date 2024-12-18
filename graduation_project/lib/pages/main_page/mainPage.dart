import 'package:flutter/material.dart';
import 'package:graduation_project/component/myDrawer.dart';
import 'package:graduation_project/pages/constant.dart';
import 'package:graduation_project/pages/home/cart_list.dart';
import 'package:graduation_project/pages/home/home_page.dart';
import 'package:graduation_project/pages/home/my_cart.dart';
import 'package:graduation_project/pages/orders/orders.dart';
import 'package:graduation_project/pages/you/you.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<MainHomePage> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Shoopy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const Icon(Icons.shopping_bag_outlined),
          backgroundColor: backgroundColor,
          shadowColor: const Color.fromARGB(255, 98, 98, 98),
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
        ),
        endDrawer: const MyDrawer(),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          backgroundColor: const Color.fromARGB(255, 188, 188, 188),
          indicatorColor: const Color.fromARGB(255, 255, 255, 255),
          selectedIndex: currentPageIndex,
          animationDuration: Durations.extralong4,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              label: 'You',
            ),
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.library_books_outlined),
              label: 'Orders',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'My Cart',
            ),
          ],
        ),
        body: <Widget>[
          You(),
          HomePage(),
          Orders(),
          MyCart(),
        ][currentPageIndex],
      ),
    );
  }
}
