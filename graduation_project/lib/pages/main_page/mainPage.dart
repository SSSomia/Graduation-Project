import 'package:flutter/material.dart';
import 'package:graduation_project/utils/component/myDrawer.dart';
import 'package:graduation_project/pages/constant.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/home/home_page.dart';
import 'package:graduation_project/pages/cart/my_cart.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shoopy',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.shopping_bag_outlined),
        backgroundColor: const Color.fromARGB(255, 244, 255, 254),
        //  shadowColor: const Color.fromARGB(255, 252, 252, 252),
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
        backgroundColor: const Color.fromARGB(255, 82, 157, 165),
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
        const You(),
        HomePage(),
        Orders(),
        MyCart(),
      ][currentPageIndex],
    );
  }
}
