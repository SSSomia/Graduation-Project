import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/market_provider.dart';
import '../widgets/product_item.dart';
import 'add_product_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final marketProvider = Provider.of<MarketProvider>(context);
    final market = marketProvider.market;

    return Scaffold(
      appBar: AppBar(title: Text(market.name)),
      body: ListView.builder(
        itemCount: market.products.length,
        itemBuilder: (ctx, i) => ProductItem(product: market.products[i]),
      ),
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
