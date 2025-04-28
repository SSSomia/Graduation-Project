import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/cart_model.dart';
import 'package:graduation_project/api_models/product_module.dart';
import 'package:graduation_project/api_providers/login_provider.dart';
import 'package:graduation_project/api_providers/product_provider.dart';
import 'package:graduation_project/api_providers/products_provider.dart';
import 'package:graduation_project/models/order_module.dart';
import 'package:graduation_project/providers/cart_list.dart';
import 'package:graduation_project/screens/my_cart.dart';
import 'package:graduation_project/models/order_item.dart';
import 'package:graduation_project/providers/order_list.dart';
import 'package:graduation_project/product_list/product_list.dart';
import 'package:graduation_project/models/product_module.dart';
import 'package:graduation_project/widgets/stock.dart';
import 'package:graduation_project/widgets/add_to_cart_button.dart';
import 'package:graduation_project/widgets/favorite_button.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key, required this.productid});
  int productid;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<ProductProvider>(context, listen: false)
          .fetchProductById(authProvider.token, widget.productid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 246, 246),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 228, 246, 254),
          title: const Text("Product Details"),
        ),
        body: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productProvider.error != null) {
            return Center(child: Text('Error: ${productProvider.error}'));
          }

          if (productProvider.product == null) {
            return const Center(child: Text('No product found'));
          }

          final product = productProvider.product;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image Section
                Stack(children: [
                  SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: product!.imageUrls.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(30), // Curve here
                                child: Image.network(
                                  product.imageUrls[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              product.imageUrls.length,
                              (index) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentIndex == index ? 12 : 8,
                                height: _currentIndex == index ? 12 : 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentIndex == index
                                      ? Colors.teal
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                          productid: widget.productid,
                          name: product.name,
                          image: product.imageUrls[0],
                        ),
                      ))
                ]),
                const SizedBox(height: 25),
                Text(
                  '${product.price}\$',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Product Title and Description
                const SizedBox(height: 5),
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                // Price and Add to Cart Button
                Stock(
                  stockQuantity: product.stockQuantity.toString(),
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 350,
                    child: AddToCartButton(
                      product: CartItem(
                          productId: product.productId,
                          productName: product.name,
                          price: product.price,
                          quantity: 1,
                          totalPrice: product.price,
                          imageUrl: product.imageUrls[0]),
                      border: 50,
                      backgroundButtonColor:
                          const Color.fromARGB(255, 222, 233, 233),
                      foreButtonColor: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                // Center(
                //   child: SizedBox(
                //     height: 50,
                //     width: 350,
                //     child: FilledButton(
                //       style: ButtonStyle(
                //           backgroundColor: WidgetStateProperty.all<Color>(
                //               const Color.fromARGB(255, 50, 116, 138))),
                //       onPressed: () {
                //         showAddressDialog(context);
                //         // Navigate to checkout or further actions
                //       },
                //       child: const Text('Buy Now'),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        }));
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
                          backgroundColor:
                              const Color.fromARGB(255, 65, 170, 192),
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

                            // _showConfirmDialog();
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

//   void _showConfirmDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Purchase'),
//           content: const Text('Are you sure you want to buy this item?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Provider.of<ProductList>(context, listen: false)
//                     .decreaseProductQuantityByOne(widget.product.stockQuantity);
//                 Provider.of<OrderList>(context, listen: false).newOrder(
//                   OrderModule(
//                     orderId: orderNumer.toString(),
//                     orderItems: [OrderItem(product: widget.product)],
//                     dateTime: DateTime.now(),
//                     status: "new",
//                     totalPrice: widget.product.price,
//                   ),
//                 );
//                 orderNumer++;

//                 Navigator.of(context).pop();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Purchase Confirmed!'),
//                     behavior: SnackBarBehavior.floating,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 );
//                 setState(() {
//                   widget.product.stock--;
//                 });
//               },
//               child: const Text('Buy Now'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
}
