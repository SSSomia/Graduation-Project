// import 'package:flutter/material.dart';
// import 'package:graduation_project/pages/cart/cart_list.dart';
// import 'package:graduation_project/product_page/product_module.dart';
// import 'package:provider/provider.dart';

// class AddToCartButton extends StatelessWidget {
//   AddToCartButton({required this.product, super.key, required this.border});
//   final Product product;
//   final double border;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartList>(
//       builder: (context, cartList, child) {
//         final isAdded = product.isAdded; // Check product in cart

//         return ElevatedButton(
//           onPressed: () {
//             isAdded
//                 ? ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('The item is aleardy added!')),
//                   )
//                 : cartList.addItem(product);
//           },
//           style: ElevatedButton.styleFrom(
//             shadowColor: const Color.fromARGB(255, 80, 80, 80),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(border),
//             ),
//           ),
//           child:
//               isAdded ? const Text("Added To Cart") : const Text("Add To Cart"),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/constant.dart';
import 'package:graduation_project/pages/product_page/product_list.dart';
import 'package:graduation_project/pages/product_page/product_module.dart';
import 'package:provider/provider.dart';

class AddToCartButton extends StatefulWidget {
  AddToCartButton(
      {required this.product,
      super.key,
      required this.border,
      required this.backgroundButtonColor,
      required this.foreButtonColor});
  final Product product;
  final double border;
  Color backgroundButtonColor = const Color.fromARGB(255, 221, 230, 233);
  Color foreButtonColor = const Color.fromARGB(255, 0, 0, 0);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartList>(builder: (context, cartList, child) {
      return ElevatedButton(
        onPressed: () {
          if (cartList.isProductExist(widget.product)) {
            widget.product.stock +=
                cartList.cartList[widget.product.id]!.quantity;
            Provider.of<ProductList>(context, listen: false)
                .increaseProductQuantity(widget.product.id,
                    cartList.cartList[widget.product.id]!.quantity);
            cartList.removeAllItem(widget.product);
          } else {
            cartList.addItem(widget.product);
            Provider.of<ProductList>(context, listen: false)
                .decreaseProductQuantityByOne(widget.product.id);
          }
          setState(() {
            widget.product.isAdded = !widget.product.isAdded;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: (cartList.isProductExist(widget.product))
              ? const Color.fromARGB(255, 122, 206, 203)
              : widget.backgroundButtonColor,
          shadowColor: const Color.fromARGB(255, 80, 80, 80),
          foregroundColor: widget.foreButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.border),
          ),
        ),
        child: (cartList.isProductExist(widget.product))
            ? const Text("Added To Cart")
            : const Text("Add To Cart"),
      );
    });
  }
}
