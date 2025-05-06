import 'package:flutter/material.dart';
import 'package:graduation_project/providers/cart_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/orders_provider.dart';
import 'package:graduation_project/screens/product/productPage.dart';
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
                                "\$${cartProvider.cart!.totalCartPrice.toStringAsFixed(2)}",
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
                                      showAddressDialog(context);
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
                          return ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                        productid: item.productId))),
                            leading: Image.network(
                              item.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(item.productName),
                            subtitle: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    if (item.quantity > 1) {
                                      cartProvider.updateQuantity(
                                          item.productId,
                                          item.quantity - 1,
                                          authProvider.token);
                                    } else if (item.quantity == 1) {
                                      cartProvider.removeFromCart(
                                          item.productId, authProvider.token);
                                    }
                                  },
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    cartProvider.updateQuantity(item.productId,
                                        item.quantity + 1, authProvider.token);
                                  },
                                ),
                              ],
                            ),
                            trailing:
                                Text('\$${item.totalPrice.toStringAsFixed(2)}'),
                          );
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

    final _formKey = GlobalKey<FormState>();

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
                            Consumer<OrderProvider>(
                                builder: (context, order, child) {
                              return ElevatedButton.icon(
                                label: const Text(
                                  "Buy Now",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 26, 123, 118),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final authProvider =
                                        Provider.of<LoginProvider>(context,
                                            listen: false);
                                    await order.placeOrderFromCart(
                                        fullName: fullNameController.text,
                                        address: addressController.text,
                                        city: cityController.text,
                                        government: governmentController.text,
                                        phoneNumber: phoneController.text,
                                        token: authProvider.token);
                                    final cart = Provider.of<CartProvider>(
                                        context,
                                        listen: false);
                                    cart.clearCartLocally();
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
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
        validator: (value) {
          final RegExp phoneRegExp = RegExp(r'^(010|011|012|015)[0-9]{8}$');

          if (value == null || value.trim().isEmpty) {
            return 'Enter $label';
          } else if (!phoneRegExp.hasMatch(value)) {
            return "Phone number isn't true";
          } else
            return null;
        });
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
