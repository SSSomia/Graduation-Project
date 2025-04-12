import 'package:flutter/material.dart';
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
  ProductPage({super.key, required this.product});
  Product product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 246, 254),
        title: Text(widget.product.productName),
      ),
      body: Padding(
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
                      itemCount: widget.product.imageUrl.length,
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
                              widget.product.imageUrl[index],
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
                          widget.product.imageUrl.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
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
                      product: widget.product,
                    ),
                  ))
            ]),
            const SizedBox(height: 25),
            Text(
              '${widget.product.price}\$',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Product Title and Description
            const SizedBox(height: 5),
            Text(
              widget.product.productName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.discription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            // Price and Add to Cart Button
            Stock(productID: widget.product.id),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                height: 50,
                width: 350,
                child: AddToCartButton(
                  product: widget.product,
                  border: 50,
                  backgroundButtonColor:
                      const Color.fromARGB(255, 222, 233, 233),
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
                          const Color.fromARGB(255, 50, 116, 138))),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text('Confirm Purchase'),
                            content: const Text(
                                'Are you sure you want to buy this item?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              // Consumer<OrderList>(
                              //     builder: (context, order, child) {
                              //   return
                              ElevatedButton(
                                  onPressed: () {
                                    Provider.of<ProductList>(context,
                                            listen: false)
                                        .decreaseProductQuantityByOne(
                                            widget.product.id);
                                    Provider.of<OrderList>(context,
                                            listen: false)
                                        .newOrder(OrderModule(
                                      orderId: orderNumer.toString(),
                                      orderItems: [
                                        OrderItem(
                                          product: widget.product,
                                        ),
                                      ],
                                      dateTime: DateTime.now(),
                                      status: "new",
                                      totalPrice: widget.product.price,
                                    ));
                                    orderNumer++;
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          content: const Text(
                                              'Purchase Confirmed!')),
                                    );
                                    setState(() {
                                      widget.product.stock--;
                                    });
                                  },
                                  child: const Text('Buy Now'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 3, 88, 98),
                                    foregroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ))
                            ]);

                        // Navigate to checkout or further actions
                      },
                    );
                  },
                  child: const Text('Buy Now'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
