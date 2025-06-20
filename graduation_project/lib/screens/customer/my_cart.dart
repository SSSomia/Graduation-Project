import 'package:flutter/material.dart';
import 'package:graduation_project/providers/cart_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/orders_provider.dart';
import 'package:graduation_project/screens/customer/product/productPage.dart';
import 'package:graduation_project/widgets/promo_code_dialog.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<CartProvider>(context, listen: false)
          .loadCart(authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final authProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      body: cartProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartProvider.cart == null
              ? const Center(child: Text('Cart is empty!!'))
              : Column(
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
                                "${cartProvider.cart!.totalCartPrice.toStringAsFixed(2)} EGP",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 3, 88, 98),
                            ),
                            TextButton(
                              onPressed: cartProvider.cart!.cartItems.isEmpty
                                  ? null
                                  : () {
                                      // showAddressDialog(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => PromoCodeDialog(),
                                      );
                                    },
                              child: const Text(
                                "Checkout",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(10),
                        itemCount: cartProvider.cart!.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartProvider.cart!.cartItems[index];
                          return Card(
                            color: const Color.fromARGB(255, 255, 248, 248),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17)),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      item.imageUrl,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Product Info and Quantity Control
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.productName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Price: ${(item.totalPrice / item.quantity).toStringAsFixed(2)} EGP',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (item.quantity > 1) {
                                                  cartProvider.updateQuantity(
                                                    item.productId,
                                                    item.quantity - 1,
                                                    authProvider.token,
                                                  );
                                                } else {
                                                  cartProvider.removeFromCart(
                                                    item.productId,
                                                    authProvider.token,
                                                  );
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.remove,
                                                    color: Colors.redAccent),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Text(
                                                '${item.quantity}',
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cartProvider.updateQuantity(
                                                  item.productId,
                                                  item.quantity + 1,
                                                  authProvider.token,
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.green
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.add,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Total & Details
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(height: 25,),
                                      Text(
                                        '${item.totalPrice.toStringAsFixed(2)} EGP',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1B6B6A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );

                          // return Card(
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(16)),
                          //   elevation: 2,
                          //   margin: const EdgeInsets.symmetric(
                          //       vertical: 8, horizontal: 6),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(12),
                          //     child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         ClipRRect(
                          //           borderRadius: BorderRadius.circular(12),
                          //           child: Image.network(
                          //             item.imageUrl,
                          //             width: 80,
                          //             height: 80,
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //         const SizedBox(width: 12),
                          //         Expanded(
                          //           child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Text(
                          //                 item.productName,
                          //                 style: const TextStyle(
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 16,
                          //                 ),
                          //               ),
                          //               const SizedBox(height: 4),
                          //               Row(
                          //                 children: [
                          //                   IconButton(
                          //                     icon: const Icon(
                          //                         Icons.remove_circle_outline),
                          //                     onPressed: () {
                          //                       if (item.quantity > 1) {
                          //                         cartProvider.updateQuantity(
                          //                           item.productId,
                          //                           item.quantity - 1,
                          //                           authProvider.token,
                          //                         );
                          //                       } else {
                          //                         cartProvider.removeFromCart(
                          //                           item.productId,
                          //                           authProvider.token,
                          //                         );
                          //                       }
                          //                     },
                          //                   ),
                          //                   Text(
                          //                     '${item.quantity}',
                          //                     style:
                          //                         const TextStyle(fontSize: 16),
                          //                   ),
                          //                   IconButton(
                          //                     icon: const Icon(
                          //                         Icons.add_circle_outline),
                          //                     onPressed: () {
                          //                       cartProvider.updateQuantity(
                          //                         item.productId,
                          //                         item.quantity + 1,
                          //                         authProvider.token,
                          //                       );
                          //                     },
                          //                   ),
                          //                 ],
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         Column(
                          //           children: [
                          //             Text(
                          //               '\$${item.totalPrice.toStringAsFixed(2)}',
                          //               style: const TextStyle(
                          //                 fontSize: 16,
                          //                 fontWeight: FontWeight.bold,
                          //                 color: Colors.green,
                          //               ),
                          //             ),
                          //             const SizedBox(height: 6),
                          //             GestureDetector(
                          //               onTap: () {
                          //                 Navigator.push(
                          //                   context,
                          //                   MaterialPageRoute(
                          //                     builder: (context) => ProductPage(
                          //                         productid: item.productId),
                          //                   ),
                          //                 );
                          //               },
                          //               child: const Text(
                          //                 'Details',
                          //                 style: TextStyle(
                          //                   fontSize: 13,
                          //                   decoration:
                          //                       TextDecoration.underline,
                          //                   color: Colors.blueAccent,
                          //                 ),
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // );
                          // return ListTile(
                          //   onTap: () => Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => ProductPage(
                          //               productid: item.productId))),
                          //   leading: Image.network(
                          //     item.imageUrl,
                          //     width: 50,
                          //     height: 50,
                          //     fit: BoxFit.cover,
                          //   ),
                          //   title: Text(item.productName),
                          //   subtitle: Row(
                          //     children: [
                          //       IconButton(
                          //         icon: const Icon(Icons.remove_circle_outline),
                          //         onPressed: () {
                          //           if (item.quantity > 1) {
                          //             cartProvider.updateQuantity(
                          //                 item.productId,
                          //                 item.quantity - 1,
                          //                 authProvider.token);
                          //           } else if (item.quantity == 1) {
                          //             cartProvider.removeFromCart(
                          //                 item.productId, authProvider.token);
                          //           }
                          //         },
                          //       ),
                          //       Text('${item.quantity}'),
                          //       IconButton(
                          //         icon: const Icon(Icons.add_circle_outline),
                          //         onPressed: () {
                          //           cartProvider.updateQuantity(item.productId,
                          //               item.quantity + 1, authProvider.token);
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          //   trailing:
                          //       Text('\$${item.totalPrice.toStringAsFixed(2)}'),
                          // );
                        },
                        separatorBuilder: (context, index) => const Divider(
                          color: Color.fromARGB(255, 194, 194, 194),
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Future<void> showAddressDialog(BuildContext context) async {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController governmentController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController couponController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final originalPrice = cartProvider.cart!.totalCartPrice;
    double discountedPrice = originalPrice;

    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          insetPadding: const EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.85,
                    ),
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
                                color: Color.fromARGB(255, 48, 150, 147),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  _buildTextField(
                                    controller: fullNameController,
                                    label: 'Full Name',
                                    icon: Icons.abc_outlined,
                                  ),
                                  const SizedBox(height: 12),
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
                                    validator: (value) {
                                      final phoneRegExp = RegExp(
                                          r'^(010|011|012|015)[0-9]{8}$');
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Enter Phone Number';
                                      } else if (!phoneRegExp.hasMatch(value)) {
                                        return "Phone number isn't valid";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  _buildTextField(
                                    controller: couponController,
                                    label: 'Coupon Code',
                                    icon: Icons.discount,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     applyCoupon(value);
                                    //   });
                                    // },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Original Price:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${originalPrice.toStringAsFixed(2)} EGP",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Discounted Price:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${discountedPrice.toStringAsFixed(2)} EGP",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 26, 123, 118),
                                  ),
                                ),
                              ],
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
                                Consumer<OrderProvider>(
                                  builder: (context, order, child) {
                                    return ElevatedButton.icon(
                                      label: const Text(
                                        "Buy Now",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 26, 123, 118),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final authProvider =
                                              Provider.of<LoginProvider>(
                                                  context,
                                                  listen: false);
                                          await order.placeOrderFromCart(
                                            fullName: fullNameController.text,
                                            address: addressController.text,
                                            city: cityController.text,
                                            government:
                                                governmentController.text,
                                            phoneNumber: phoneController.text,
                                            token: authProvider.token,
                                          );
                                          cartProvider.clearCartLocally();
                                          Navigator.pop(context);
                                        }
                                      },
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
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
    String? Function(String?)? validator, // <- Optional custom validator
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        filled: true,
        fillColor: const Color.fromARGB(255, 225, 225, 225),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Enter $label';
            }
            return null;
          },
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Purchase'),
          content: const Text(
              'This will simulate confirming the purchase from cart.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Just show success message
                Navigator.of(context).pop();
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
            ),
          ],
        );
      },
    );
  }
}
