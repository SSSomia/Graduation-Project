import 'package:flutter/material.dart';
import 'package:graduation_project/pages/home/cart_list.dart';
import 'package:graduation_project/pages/home/product_module.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  ProductCard( {required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        width: 200,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    product.imageUrl,
                    height: 148,
                    fit: BoxFit.cover,
                  ),
                ),
                // Details
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 90, 89, 89),
                        ),
                      ),
                      // const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<CartList>(context, listen: false)
                              .addItem(product);
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text("Add to Cart"),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
