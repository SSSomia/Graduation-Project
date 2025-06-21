import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/orders_provider.dart';
import 'package:graduation_project/providers/product_provider.dart';
import 'package:graduation_project/providers/seller_product_provider.dart';
import 'package:graduation_project/screens/seller/product/update_product_screen.dart';
import 'package:graduation_project/widgets/product_reviews.dart';
import 'package:graduation_project/widgets/stock.dart';
import 'package:provider/provider.dart';

class SellerProductPage extends StatefulWidget {
  SellerProductPage({super.key, required this.productid});
  int productid;

  @override
  State<SellerProductPage> createState() => _SellerProductPageState();
}

class _SellerProductPageState extends State<SellerProductPage> {
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
          backgroundColor: const Color.fromARGB(255, 255, 246, 246),
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
                                      ? const Color.fromARGB(255, 158, 43, 43)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 350,
                    child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 137, 22, 22))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateProductScreen(product: product),
                          ),
                        );

                        // Navigate to checkout or further actions
                      },
                      child: const Text('Edit'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 350,
                    child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 221, 0, 0))),
                      onPressed: () async {
                        try {
                          final authProvider = Provider.of<LoginProvider>(
                              context,
                              listen: false);
                          final sellerProductProvider =
                              Provider.of<SellerProductProvider>(context,
                                  listen: false);

                          await sellerProductProvider.deleteProduct(
                              authProvider.token, widget.productid);
                          await sellerProductProvider
                              .fetchMyProducts(authProvider.token);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Deleted successfully')),
                          );
                            Navigator.pop(context);
                          // Optionally, navigate back or refresh the UI
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                        // Navigate to checkout or further actions
                      },
                      child: const Text('Delete'),
                    ),
                  ),
                ),
                // ProductReviewsList(
                //     productId: productProvider.product!.productId),
       
              ],
            ),
          ));
        }));
  }
}