import 'package:flutter/material.dart';
import 'package:graduation_project/providers/orders_provider.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/login_provider.dart';

class AddressDialog extends StatefulWidget {
  const AddressDialog({super.key});

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController governmentController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  double? discountedPrice;

  @override
  void initState() {
    super.initState();
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    discountedPrice = cartProvider.cart?.totalCartPrice ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final originalPrice = cartProvider.cart?.totalCartPrice ?? 0.0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
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
                          final phoneRegExp =
                              RegExp(r'^(010|011|012|015)[0-9]{8}$');
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Phone Number';
                          } else if (!phoneRegExp.hasMatch(value)) {
                            return "Phone number isn't valid";
                          }
                          return null;
                        },
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
                      "${discountedPrice?.toStringAsFixed(2)} EGP",
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
                            backgroundColor:
                                const Color.fromARGB(255, 26, 123, 118),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final authProvider = Provider.of<LoginProvider>(
                                  context,
                                  listen: false);

                              await order.placeOrderFromCart(
                                fullName: fullNameController.text,
                                address: addressController.text,
                                city: cityController.text,
                                government: governmentController.text,
                                phoneNumber: phoneController.text,
                                token: authProvider.token,
                              );
                              cartProvider.clearCartLocally();
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.shopping_cart_checkout),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
