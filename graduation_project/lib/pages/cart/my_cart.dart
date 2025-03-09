import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/cart/list_tile_item.dart';
import 'package:graduation_project/pages/orders/order_list.dart';
import 'package:graduation_project/pages/orders/order_module.dart';
import 'package:graduation_project/pages/product_page/product_list.dart';
import 'package:provider/provider.dart';

int orderNumer = 0;

class MyCart extends StatelessWidget {
  MyCart({super.key});
  // CartList _cartList = CartList();
  @override
  Widget build(BuildContext context) {
    final cartList = Provider.of<CartList>(context);
    return cartList.cartList.isEmpty
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
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 3, 88, 98),
                              );
                            },
                          ),
                          TextButton(
                            onPressed: cartList.cartList.isEmpty
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
                                            Consumer<OrderList>(builder:
                                                (context, order, child) {
                                              return ElevatedButton(
                                                onPressed: () {
                                                  order.newOrder(OrderModule(
                                                    orderId:
                                                        orderNumer.toString(),
                                                    orderItems: cartList
                                                        .cartList.values
                                                        .toList(),
                                                    dateTime: DateTime.now(),
                                                    status: "new",
                                                    totalPrice:
                                                        cartList.totalPrice,
                                                  ));
                                                  orderNumer++;
                                                  Navigator.of(context).pop();
                                                  cartList.clearCart();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        content: const Text(
                                                            'Purchase Confirmed!')),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 3, 88, 98),
                                                  foregroundColor:
                                                      const Color.fromARGB(
                                                          255, 255, 255, 255),
                                                ),
                                                child: const Text('Buy Now'),
                                              );
                                            }),
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
                itemCount: cartList.cartList.length,
                itemBuilder: (context, index) {
                  final item = cartList.cartList.values.toList()[index];
                  return Column(
                    children: [
                      ListTileItem(item: item.product),
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
