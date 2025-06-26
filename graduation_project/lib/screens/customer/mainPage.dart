import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/products_provider.dart';
import 'package:graduation_project/screens/customer/profile/profile_page.dart';
import 'package:graduation_project/screens/customer/scroll_main_page.dart';
import 'package:graduation_project/screens/customer/search_screen.dart';
import 'package:graduation_project/widgets/myDrawer.dart';
import 'package:graduation_project/screens/customer/home_page.dart';
import 'package:graduation_project/screens/customer/my_cart.dart';
import 'package:graduation_project/screens/customer/orders/orders.dart';
import 'package:graduation_project/widgets/scrolle_banner.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<MainHomePage> {
  int currentPageIndex = 1;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Spark Up',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.shopping_bag_outlined),
        actions: [
          currentPageIndex == 1
              ? IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    final authProvider =
                        Provider.of<LoginProvider>(context, listen: false);
                    Provider.of<ProductsProvider>(context, listen: false)
                        .fetchRandomProducts(authProvider.token);
                  })
              : SizedBox.shrink(),
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Icon(Icons.menu))
        ],
        backgroundColor: const Color.fromARGB(255, 255, 250, 250),
        //  shadowColor: const Color.fromARGB(255, 252, 252, 252),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
      endDrawer: MyDrawer(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: const Color.fromARGB(255, 173, 26, 26),
        indicatorColor: const Color.fromARGB(255, 255, 227, 227),
        selectedIndex: currentPageIndex,
        animationDuration: Durations.extralong4,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.person_outline_rounded,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            label: 'You',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.search,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            label: 'My Cart',
          ),
        ],
      ),
      body: <Widget>[
        const You(),
        ScrollMainPage(),
        const SearchScreen(),
        const MyCart(),
      ][currentPageIndex],
    );
  }
}
