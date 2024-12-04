import 'package:flutter/material.dart';
import 'package:graduation_project/pages/home/home_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<MainHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          you(),
          HomePage(),
          DashBoard(),
          MyCart(),
        ][currentPageIndex],
      ),
    );
  }

  you() {}

  DashBoard() {}
}
