import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_product_provider.dart';
import 'package:graduation_project/screens/seller/product/add_product_screen.dart';
import 'package:graduation_project/widgets/product_item.dart';
import 'package:provider/provider.dart';

class MarketProductScreen extends StatefulWidget {
  @override
  State<MarketProductScreen> createState() => _MarketProductScreenState();
}

class _MarketProductScreenState extends State<MarketProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<SellerProductProvider>(context, listen: false)
          .fetchMyProducts(authProvider.token);
    });
  }

  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Products',
        style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 244, 255, 254),
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
    ),
    body: Consumer<SellerProductProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = provider.products;

        if (products.isEmpty) {
          return const Center(child: Text("No products available."));
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, i) => ProductItem(product: products[i]),
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddProductScreen()),
        );
      },
    ),
  );
}

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text(
  //         'Products',
  //         style: TextStyle(
  //           color: Color.fromARGB(255, 0, 0, 0),
  //           fontSize: 25,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       backgroundColor: const Color.fromARGB(255, 244, 255, 254),
  //       //  shadowColor: const Color.fromARGB(255, 252, 252, 252),
  //       elevation: 10,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             bottomLeft: Radius.circular(20),
  //             bottomRight: Radius.circular(20)),
  //       ),
  //     ),
  //     body: // Center(child: Text("MARKET PRODUCT")),
  //         Consumer<SellerProductProvider>(// ✅ Listen to changes
  //             builder: (context, provider, child) {
  //       if (provider.isLoading) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //       final authProvider = Provider.of<LoginProvider>(context, listen: false);
  //       Provider.of<SellerProductProvider>(context, listen: false)
  //           .fetchMyProducts(authProvider.token);
  //       final products = provider.products;
  //       return ListView.builder(
  //         itemCount: products.length,
  //         itemBuilder: (ctx, i) => ProductItem(product: products[i]),
  //       );
  //     }),
  //     floatingActionButton: FloatingActionButton(
  //       child: const Icon(Icons.add),
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => AddProductScreen()),
  //         );
  //       },
    //   ),
    // );
  // }
}
