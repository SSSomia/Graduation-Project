import 'package:flutter/material.dart';
import 'package:graduation_project/product_list/product_list.dart';
import 'package:provider/provider.dart';

class Stock extends StatelessWidget {
  String productID;
  Stock({super.key, required this.productID});


  @override
  Widget build(BuildContext context) {
   final product = Provider.of<ProductList>(context).productMap[productID];
    return Row(
      children: [
        const Text(
          'In Stock: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '${product!.stock}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}
