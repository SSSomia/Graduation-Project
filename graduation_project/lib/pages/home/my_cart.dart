import 'package:flutter/material.dart';
import 'package:graduation_project/pages/home/cart_list.dart';
import 'package:graduation_project/pages/home/product_card.dart';
import 'package:graduation_project/pages/home/product_module.dart';
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
                          Chip(
                            label: Text(
                              "\$${_cartList.totalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          TextButton(
                            onPressed: _cartList.cartList.isEmpty
                                ? null
                                : () {
                                    // Handle checkout
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Checkout Not Implemented")),
                                    );
                                  },
                            child: const Text("Checkout"),
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
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item.imageUrl),
                        ),
                        title: Text(item.productName),
                        subtitle:
                            Text("Price: \$${item.price.toStringAsFixed(2)}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                if (item.quantity > 1) {
                                  _cartList.updateQuantity(
                                      item, item.quantity - 1);
                                } else {
                                  _cartList.removeItem(item);
                                }
                              },
                            ),
                            Text("${item.quantity}"),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                _cartList.addItem(item);
                              },
                            ),
                          ],
                        ),
                      ),
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
