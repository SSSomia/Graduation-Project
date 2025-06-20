import 'package:flutter/material.dart';
import 'package:graduation_project/modelNotUse/copoun_model_test.dart';
import 'package:graduation_project/providers/orders_provider.dart';
import 'package:graduation_project/providers/promo_code.dart';
import 'package:graduation_project/screens/customer/orders/order_success_screen.dart';
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
    // discountedPrice = cartProvider.cart?.totalCartPrice ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final promoCode = Provider.of<PromoCodeProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    // final originalPrice = cartProvider.cart?.totalCartPrice ?? 0.0;

    // return Dialog(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //   elevation: 5,
    //   insetPadding: const EdgeInsets.all(20),
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints(
    //       maxHeight: MediaQuery.of(context).size.height * 0.85,
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(20),
    //       child: SingleChildScrollView(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             const Text(
    //               "Address Details",
    //               style: TextStyle(
    //                 fontSize: 22,
    //                 fontWeight: FontWeight.bold,
    //                 color: Color.fromARGB(255, 48, 150, 147),
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             Form(
    //               key: _formKey,
    //               child: Column(
    //                 children: [
    //                   _buildTextField(
    //                     controller: fullNameController,
    //                     label: 'Full Name',
    //                     icon: Icons.abc_outlined,
    //                   ),
    //                   const SizedBox(height: 12),
    //                   _buildTextField(
    //                     controller: governmentController,
    //                     label: 'Government',
    //                     icon: Icons.location_city,
    //                   ),
    //                   const SizedBox(height: 12),
    //                   _buildTextField(
    //                     controller: cityController,
    //                     label: 'City',
    //                     icon: Icons.location_on_outlined,
    //                   ),
    //                   const SizedBox(height: 12),
    //                   _buildTextField(
    //                     controller: addressController,
    //                     label: 'Detailed Address',
    //                     icon: Icons.home,
    //                   ),
    //                   const SizedBox(height: 12),
    //                   _buildTextField(
    //                     controller: phoneController,
    //                     label: 'Phone Number',
    //                     icon: Icons.phone,
    //                     keyboardType: TextInputType.phone,
    //                     validator: (value) {
    //                       final phoneRegExp =
    //                           RegExp(r'^(010|011|012|015)[0-9]{8}$');
    //                       if (value == null || value.trim().isEmpty) {
    //                         return 'Enter Phone Number';
    //                       } else if (!phoneRegExp.hasMatch(value)) {
    //                         return "Phone number isn't valid";
    //                       }
    //                       return null;
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(height: 16),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 const Text(
    //                   "Discount Percentage:",
    //                   style: TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //                 Text(
    //                   promoCode.result != null
    //                       ? "${promoCode.discountPercentage!} %"
    //                       : '0 %',
    //                   style: const TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.red,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 24),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 TextButton(
    //                   style: TextButton.styleFrom(
    //                     foregroundColor: const Color.fromARGB(255, 13, 26, 26),
    //                   ),
    //                   onPressed: () => Navigator.pop(context),
    //                   child: const Text("Cancel"),
    //                 ),
    //                 const SizedBox(width: 10),
    //                 Consumer<OrderProvider>(
    //                   builder: (context, order, child) {
    //                     return ElevatedButton.icon(
    //                       label: const Text(
    //                         "Buy Now",
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                       style: ElevatedButton.styleFrom(
    //                         backgroundColor:
    //                             const Color.fromARGB(255, 26, 123, 118),
    //                         padding: const EdgeInsets.symmetric(
    //                             horizontal: 20, vertical: 12),
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(10)),
    //                       ),
    //                       onPressed: () async {
    //                         if (_formKey.currentState!.validate()) {
    //                           final authProvider = Provider.of<LoginProvider>(
    //                               context,
    //                               listen: false);

    //                           await order.placeOrderFromCart(
    //                             fullName: fullNameController.text,
    //                             address: addressController.text,
    //                             city: cityController.text,
    //                             government: governmentController.text,
    //                             phoneNumber: phoneController.text,
    //                             token: authProvider.token,
    //                           );
    //                           cartProvider.clearCartLocally();
    //                           Navigator.pop(context);
    //                           Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => OrderSuccessScreen(
    //                                     response: order.orderResponse)),
    //                           );
    //                           showDialog(
    //                             context: context,
    //                             builder: (context) => OrderSuccessScreen(
    //                               response: order.orderResponse,
    //                             ),
    //                           );
    //                         }
    //                       },
    //                       icon: const Icon(Icons.shopping_cart_checkout),
    //                     );
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // await showDialog(
    //   context: context,
    //   builder: (context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      insetPadding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Delivery Details",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1CA89E),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                      controller: fullNameController,
                      label: 'Full Name',
                      icon: Icons.person_outline),
                  const SizedBox(height: 14),
                  _buildTextField(
                      controller: governmentController,
                      label: 'Governorate',
                      icon: Icons.map_outlined),
                  const SizedBox(height: 14),
                  _buildTextField(
                      controller: cityController,
                      label: 'City',
                      icon: Icons.location_city_outlined),
                  const SizedBox(height: 14),
                  _buildTextField(
                      controller: addressController,
                      label: 'Detailed Address',
                      icon: Icons.home_outlined),
                  const SizedBox(height: 14),
                  _buildTextField(
                    controller: phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 24),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(children: [
                        _priceRow(
                          "Discount Percentage:",
                          " ${promoCode.discountPercentage} %",
                        ),
                      ])),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[800],
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 12),
                      Consumer<OrderProvider>(
                        builder: (context, order, child) {
                          return ElevatedButton.icon(
                              icon: const Icon(Icons.shopping_bag_outlined,
                                  color: Colors.white),
                              label: const Text(
                                "Buy Now",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1CA89E),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              // onPressed: () async {
                              //   if (_formKey.currentState!.validate()) {
                              //     final authProvider =
                              //         Provider.of<LoginProvider>(context,
                              //             listen: false);
                              //     final result = await order.placeOrder(
                              //       productId: productId,
                              //       quantity: 1,
                              //       fullName: fullNameController.text,
                              //       address: addressController.text,
                              //       city: cityController.text,
                              //       government: governmentController.text,
                              //       phoneNumber: phoneController.text,
                              //       token: authProvider.token,
                              //       couponCode: couponController.text.trim(),
                              //       finalPrice: discountedPrice,
                              //     );
                              //     print(result);
                              //     Navigator.pop(context);
                              //     showDialog(
                              //       context: context,
                              //       builder: (context) => OrderSuccessScreen(
                              //         response: order.orderResponse,
                              //       ),
                              //     );
                              //   }
                              // },
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
                                    token: authProvider.token,
                                  );
                                  cartProvider.clearCartLocally();
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderSuccessScreen(
                                                response: order.orderResponse)),
                                  );
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) => OrderSuccessScreen(
                                  //     response: order.orderResponse,
                                  //   ),
                                  // );
                                }
                              });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  Function(String)? onChanged,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    onChanged: onChanged,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF7F9FA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    validator: (value) =>
        value == null || value.trim().isEmpty ? 'Please enter $label' : null,
  );
}

Widget _priceRow(String label, String value,
    {bool strikeThrough = false, bool highlight = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: highlight ? const Color(0xFF1CA89E) : Colors.grey[800],
          decoration:
              strikeThrough ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
    ],
  );
}
