import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project/screens/edit_product_screen.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../providers/market_provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    final marketProvider = Provider.of<MarketProvider>(context, listen: false);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        leading: Image.file(
          File(product.imageUrl[0]), // Using File path
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.productName,
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category: ${product.category}"),
            Text("Price: \$${product.price.toStringAsFixed(2)}"),
            Text("Stock: ${product.stock} available"),
            Text("Description: ${product.description}",
                maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.mode_edit_outline_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProductScreen(product: product),
              ),
            );
          },
        ),
      ),
    );
  }
}
