import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graduation_project/models/order_module.dart';
import 'package:graduation_project/providers/cart_list.dart';
import 'package:graduation_project/widgets/list_tile_item.dart';
import 'package:graduation_project/providers/order_list.dart';
import 'package:graduation_project/product_list/product_list.dart';
import 'package:provider/provider.dart';

int orderNumer = 0;

class MyCart extends StatefulWidget {
  MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
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
                                    showAddressDialog(context);
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

  Future<void> showAddressDialog(BuildContext context) async {
    final TextEditingController governmentController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          insetPadding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Address Details",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 65, 170, 192),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: governmentController,
                          label: 'Government',
                          icon: Icons.location_city,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: cityController,
                          label: 'City',
                          icon: Icons.location_on_outlined,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: addressController,
                          label: 'Detailed Address',
                          icon: Icons.home,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: phoneController,
                          label: 'Phone Number',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 13, 26, 26),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.check_circle),
                        label: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 65, 170, 192),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Do something with the data
                            _formKey.currentState!.save();
                            Navigator.pop(context);

                            _showConfirmDialog();
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) =>
          value == null || value.trim().isEmpty ? 'Enter $label' : null,
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final cartList = Provider.of<CartList>(context);
        return AlertDialog(
          title: const Text('Confirm Purchase'),
          content: const Text(
              'Are you sure you want to buy the items in your cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            Consumer<OrderList>(builder: (context, order, child) {
              return ElevatedButton(
                onPressed: () {
                  order.newOrder(OrderModule(
                    orderId: orderNumer.toString(),
                    orderItems: cartList.cartList.values.toList(),
                    dateTime: DateTime.now(),
                    status: "new",
                    totalPrice: cartList.totalPrice,
                  ));
                  orderNumer++;
                  Navigator.of(context).pop();
                  cartList.clearCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        content: const Text('Purchase Confirmed!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 3, 88, 98),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Text('Buy Now'),
              );
            }),
          ],
        );
      },
    );
  }
}
