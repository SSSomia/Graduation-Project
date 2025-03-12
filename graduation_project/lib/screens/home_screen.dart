import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/market_provider.dart';
import '../widgets/product_item.dart';
import 'add_product_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("market")),
      body: Consumer<MarketProvider>(// ✅ Listen to changes
          builder: (context, marketProvider, child) {
        final products = marketProvider.products;
        return ListView.builder(
                itemCount: products.length,
                itemBuilder: (ctx, i) =>
                    ProductItem(product: products[i]),
              );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
