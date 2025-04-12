import 'package:flutter/material.dart';
import 'package:graduation_project/providers/cart_list.dart';
import 'package:graduation_project/models/product_module.dart';
import 'package:graduation_project/screens/product/productPage.dart';
import 'package:graduation_project/widgets/add_to_cart_button.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  ProductCard({required this.product});
  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    //final product = Provider.of<CartList>(context).cartList;
   return SizedBox(
        height: 400,
        width: 200,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductPage(product: Product(id: widget.product.id, productName: widget.product.productName, imageUrl: widget.product.imageUrl, price: widget.product.price, category: widget.product.category, stock: widget.product.stock, discription: widget.product.discription),)),
                    );
                  },
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(
                      widget.product.imageUrl[0],
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          // Image is fully loaded
                          return child;
                        } else {
                          // Show CircularProgressIndicator while loading
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const Center(
                          child: Icon(Icons.error, color: Colors.red, size: 50),
                        );
                      },
                      height: 148,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Details
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.productName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "\$${widget.product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 90, 89, 89),
                        ),
                      ),
                      const SizedBox(height: 10),
                     AddToCartButton(product: widget.product, border: 20,backgroundButtonColor:  Color.fromARGB(255, 50, 116, 138), foreButtonColor: Colors.white,),
                    ],
                  ),
                ),
              ],
            )));
  }
}
