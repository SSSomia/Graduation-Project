import 'package:flutter/material.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/product_page/product_module.dart';
import 'package:provider/provider.dart';

class AddToCartButton extends StatefulWidget {
  AddToCartButton({required this.product, super.key, required this.border});
  final Product product;
  final double border;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.product.isAdded
            ? Provider.of<CartList>(context, listen: false)
                .removeItem(widget.product)
            : Provider.of<CartList>(context, listen: false)
                .addItem(widget.product);
        setState(() {
          widget.product.isAdded
              ? widget.product.isAdded = false
              : widget.product.isAdded = true;
        });
      },
      style: ElevatedButton.styleFrom(
        shadowColor: const Color.fromARGB(255, 80, 80, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.border),
        ),
      ),
      child: widget.product.isAdded
          ? const Text("Remove from Cart")
          : const Text("Add To Cart"),
    );
  }
}
