import 'package:flutter/material.dart';
import 'package:graduation_project/pages/home/cart_list.dart';
import 'package:graduation_project/pages/home/product_module.dart';
import 'package:provider/provider.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({required this.product, super.key});
  final Product product;

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
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: widget.product.isAdded
          ? const Text("Remove from Cart")
          : const Text("Add To Cart"),
    );
  }
}
