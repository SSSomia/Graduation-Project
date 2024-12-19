import 'package:flutter/material.dart';
import 'package:graduation_project/product_page/product_module.dart';
import 'package:graduation_project/utils/add_to_cart_button.dart';
import 'package:graduation_project/utils/favorite_press.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key, required this.product});
  Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: Text(product.productName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                  //color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(product.imageUrl), fit: BoxFit.cover),
                ),
                height: 300,
                width: double.infinity,
              ),
              Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: const FavoritePress(),
                  ))
            ]),
            const SizedBox(height: 16),
            // Product Title and Description
            Text(
              product.productName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is the product description. It gives details about the product features and specifications.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Price and Add to Cart Button
            Text(
              '${product.price}\$',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Center(
              child: SizedBox(
                height: 50,
                width: 350,
                child: AddToCartButton(product: product, border: 50),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: SizedBox(
                height: 50,
                width: 350,
                child: FilledButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 163, 163, 163))),
                  onPressed: () {
                    // Navigate to checkout or further actions
                  },
                  child: const Text('Buy Now'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
