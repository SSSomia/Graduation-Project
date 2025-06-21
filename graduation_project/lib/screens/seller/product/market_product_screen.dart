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
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
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
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add, color: Colors.white,),
        label: const Text('New Product', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 185, 28, 28),
        elevation: 4,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        },
      ),
    );
  }
}