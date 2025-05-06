import 'package:flutter/material.dart';
import 'package:graduation_project/models/cart_model.dart';
import 'package:graduation_project/providers/cart_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:provider/provider.dart';

class AddToCartButton extends StatefulWidget {
  AddToCartButton(
      {required this.product,
      super.key,
      required this.border,
      required this.backgroundButtonColor,
      required this.foreButtonColor});
  final CartItem product;
  final double border;
  Color backgroundButtonColor = const Color.fromARGB(255, 221, 230, 233);
  Color foreButtonColor = const Color.fromARGB(255, 0, 0, 0);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, child) {
      //   Guard against null cart
      if (cart == null || cart.cart == null) {
        // return const Center(child: Text("Cart is not available"));
        return ElevatedButton(
          onPressed: () {
            final authProvider =
                Provider.of<LoginProvider>(context, listen: false);
            cart.addToCart(widget.product, authProvider.token);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.backgroundButtonColor,
            shadowColor: const Color.fromARGB(255, 80, 80, 80),
            foregroundColor: widget.foreButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.border),
            ),
          ),
          child: const Text("Add To Cart"),
        );
      } else {
        return ElevatedButton(
          onPressed: () {
            final authProvider =
                Provider.of<LoginProvider>(context, listen: false);
            if (cart == null || cart.cart == null) {
              cart.addToCart(widget.product, authProvider.token);
            } else {
              if (cart.isCartItemExist(widget.product)) {
                // Remove item from cart if it already exists
                cart.removeFromCart(
                    widget.product.productId, authProvider.token);
              } else {
                cart.addToCart(widget.product, authProvider.token);
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: (cart.isCartItemExist(widget.product))
                ? const Color.fromARGB(255, 122, 206, 203)
                : widget.backgroundButtonColor,
            shadowColor: const Color.fromARGB(255, 80, 80, 80),
            foregroundColor: widget.foreButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.border),
            ),
          ),
          child: (cart.isCartItemExist(widget.product))
              ? const Text("Added To Cart")
              : const Text("Add To Cart"),
        );
      }
    });
  }
}
