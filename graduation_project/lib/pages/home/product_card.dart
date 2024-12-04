import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String imageUrl;
  final double price;

  const ProductCard({
    required this.productName,
    required this.imageUrl,
    required this.price,
    Key? key,
  }) : super(key: key);

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
                imageUrl,
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
                    productName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 90, 89, 89),
                    ),
                  ),
                  // const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // have to handle it in add to card
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
        ),
      ),
    );
  }
}
