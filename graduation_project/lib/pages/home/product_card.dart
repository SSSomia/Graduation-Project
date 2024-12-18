import 'package:flutter/material.dart';
import 'package:graduation_project/pages/home/cart_list.dart';
import 'package:graduation_project/pages/home/product_module.dart';
import 'package:graduation_project/product_page/productPage.dart';
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
              borderRadius: BorderRadius.circular(10),
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
                      MaterialPageRoute(builder: (context) => ProductPage(product: Product(id: widget.product.id, productName: widget.product.productName, imageUrl: widget.product.imageUrl, price: widget.product.price),)),
                    );
                  },
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      widget.product.imageUrl,
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
                      // const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          widget.product.isAdded
                              ? Provider.of<CartList>(context, listen: false)
                                  .removeItem(widget.product)
                              : Provider.of<CartList>(context, listen: false)
                                  .addItem(widget.product);
                          setState(() {
                            widget.product.isAdded
                                ? widget.product.isAdded = false
                                : widget.product.isAdded = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: widget.product.isAdded
                            ? const Text("Remove from Cart")
                            : const Text("Add To Cart"),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
