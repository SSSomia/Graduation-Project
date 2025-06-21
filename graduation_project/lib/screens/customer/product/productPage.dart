import 'package:flutter/material.dart';
import 'package:graduation_project/models/cart_model.dart';
import 'package:graduation_project/models/product_module.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/orders_provider.dart';
import 'package:graduation_project/providers/product_provider.dart';
import 'package:graduation_project/providers/profile_provider.dart';
import 'package:graduation_project/providers/review_provider.dart';
import 'package:graduation_project/screens/customer/orders/order_success_screen.dart';
import 'package:graduation_project/screens/seller/product/review_page.dart';
import 'package:graduation_project/widgets/product_reviews.dart';
import 'package:graduation_project/widgets/review.dart';
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
      final provider = Provider.of<ReviewProvider>(context, listen: false);

      provider.fetchReviews(widget.productid, authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<LoginProvider>(context).token;
    final reviewProvider = Provider.of<ReviewProvider>(context);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 246, 246),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 244, 244),
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
          return SingleChildScrollView(
              child: Padding(
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
                                      ? const Color.fromARGB(255, 138, 25, 25)
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
                // roduct Title + Price
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  color: const Color.fromARGB(255, 250, 250, 250),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          product.description,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              '${product.price.toStringAsFixed(2)} EGP',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 159, 49, 49)),
                            ),
                            const Spacer(),
                            Stock(
                                stockQuantity:
                                    product.stockQuantity.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                          const Color.fromARGB(255, 233, 222, 222),
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
                              const Color.fromARGB(255, 171, 33, 33))),
                      onPressed: () {
                        showAddressDialog(context, product);
                        // Navigate to checkout or further actions
                      },
                      child: const Text('Buy Now'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                ProductReviewsList(
                  productId: productProvider.product!.productId,
                  reviewsNum: 3,
                ),
                reviewProvider.reviews.isEmpty
                    ? const Text("")
                    : Center(
                        child: SizedBox(
                          height: 50,
                          width: 350,
                          child: FilledButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color.fromARGB(255, 185, 54, 54))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewPage(
                                    productId:
                                        productProvider.product!.productId,
                                  ),
                                ),
                              );
                            },
                            child: const Text('See More'),
                          ),
                        ),
                      ),
              ],
            ),
          ));
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: AddReviewWidget(productId: widget.productid),
                ),
              ),
            );
          },
          backgroundColor: const Color.fromARGB(255, 146, 20, 20),
          child: const Icon(Icons.rate_review_outlined, color: Colors.white,),
        ));
  }

  Future<void> showAddressDialog(
      BuildContext context, ProductModule product) async {
    final fullNameController = TextEditingController();
    final governmentController = TextEditingController();
    final cityController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    final couponController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    final double originalPrice = 500.0;
    double discountedPrice = originalPrice;

    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                          color:Color.fromARGB(255, 185, 28, 28),
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
                          color: const Color.fromARGB(255, 255, 241, 241),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _priceRow(
                              "Price:",
                              "${product.price} EGP",
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
                                  backgroundColor: const Color.fromARGB(255, 185, 28, 28),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final authProvider =
                                        Provider.of<LoginProvider>(context,
                                            listen: false);
                                    final result = await order.placeOrder(
                                      productId: product.productId,
                                      quantity: 1,
                                      fullName: fullNameController.text,
                                      address: addressController.text,
                                      city: cityController.text,
                                      government: governmentController.text,
                                      phoneNumber: phoneController.text,
                                      token: authProvider.token,
                                    );
                                    print(result);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Order placed successfully/")),
                                    );
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) => OrderSuccessScreen(
                                    //     response: order.,
                                    //   ),
                                    // );
                                  }
                                },
                              );
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
      },
    );
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
        fillColor:const Color.fromARGB(255, 255, 241, 241),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            color: highlight ?  const Color.fromARGB(255, 255, 241, 241): Colors.grey[800],
            decoration: strikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      ],
    );
  }

}
