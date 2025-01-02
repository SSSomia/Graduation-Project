import 'package:flutter/material.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/cart/list_tile_item.dart';
import 'package:graduation_project/pages/product_page/product_card.dart';
import 'package:graduation_project/pages/product_page/product_module.dart';
import 'package:provider/provider.dart';

class MyCart extends StatelessWidget {
  MyCart({super.key});

  // CartList _cartList = CartList();
  @override
  Widget build(BuildContext context) {
    final _cartList = Provider.of<CartList>(context);

    return _cartList.cartList.isEmpty
        ? const Scaffold(body: Center(child: Text("no items added yet")))
        : Scaffold(
            body: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          Consumer<CartList>(
                            builder: (context, cartList, child) {
                              return Chip(
                                label: Text(
                                  "\$${cartList.totalPrice.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255)),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 3, 88, 98),
                              );
                            },
                          ),
                          TextButton(
                            onPressed: _cartList.cartList.isEmpty
                                ? null
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Purchase'),
                                          content: const Text(
                                              'Are you sure you want to buy the items in your cart?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                _cartList
                                                    .clearCart(); // Close the dialog
                                                // Perform the purchase action here
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      content: const Text(
                                                          'Purchase Confirmed!')),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 3, 88, 98),
                                                foregroundColor: const Color
                                                    .fromARGB(255, 255, 255,
                                                    255), // Text (foreground) color of the button
                                              ),
                                              child: const Text('Buy Now'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                            child: const Text(
                              "Checkout",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ])),
              ),
              Expanded(
                  child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _cartList.cartList.length,
                itemBuilder: (context, index) {
                  final item = _cartList.cartList.values.toList()[index];
                  return Column(
                    children: [
                      ListTileItem(item: item),
                      const Divider(
                        height: 1,
                        color: Color.fromARGB(255, 194, 194, 194),
                      ),
                    ],
                  );
                },
              )),
            ],
          ));
  }
}
