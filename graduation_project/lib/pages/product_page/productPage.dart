import 'package:flutter/material.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/cart/my_cart.dart';
import 'package:graduation_project/pages/orders/order_list.dart';
import 'package:graduation_project/pages/orders/order_module.dart';
import 'package:graduation_project/pages/product_page/product_module.dart';
import 'package:graduation_project/utils/add_to_cart_button.dart';
import 'package:graduation_project/utils/favorite_button.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key, required this.product});
  Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 253, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 246, 254),
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
                    child: FavoriteButton(
                      product: product,
                    ),
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
                child: AddToCartButton(
                  product: product,
                  border: 50,
                  backgroundButtonColor:
                      const Color.fromARGB(255, 222, 233, 233),
                  foreButtonColor: Colors.black,
                ),
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
                          const Color.fromARGB(255, 50, 116, 138))),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text('Confirm Purchase'),
                            content: const Text(
                                'Are you sure you want to buy this item?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              // Consumer<OrderList>(
                              //     builder: (context, order, child) {
                              //   return
                                 ElevatedButton(
                                    onPressed: () {
                                      Provider.of<OrderList>(context,
                                              listen: false)
                                          .newOrder(OrderModule(
                                              orderId: orderNumer.toString(),
                                              orderItems: {
                                                product.id: OrderItem(
                                                    product: product,
                                                    price: product.price *
                                                        product.quantity)
                                              },
                                              dateTime: DateTime.now(),
                                              status: "new",
                                              totalPrice: product.price,
                                              numberOfItems: 1));

                                      // order.newOrder(OrderModule(
                                      //     orderId: orderNumer.toString(),
                                      //     orderItems: {
                                      //       product.id: OrderItem(
                                      //           product: product,
                                      //           price: product.price *
                                      //               product.quantity)
                                      //     },
                                      //     dateTime: DateTime.now(),
                                      //     status: "new",
                                      //     totalPrice: product.price,
                                      //     numberOfItems: 1));
                                      orderNumer++;
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            content: const Text(
                                                'Purchase Confirmed!')),
                                      );
                                    },
                                    child: const Text('Buy Now'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 3, 88, 98),
                                      foregroundColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ))
                            ]);

                        // Navigate to checkout or further actions
                      },
                    );
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
