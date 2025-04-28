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
import 'package:graduation_project/api_models/cart_model.dart';
import 'package:graduation_project/api_providers/cart_provider.dart';
import 'package:graduation_project/api_providers/login_provider.dart';
import 'package:provider/provider.dart';

// class AddToCartButton extends StatefulWidget {
//   AddToCartButton(
//       {required this.product,
//       super.key,
//       required this.border,
//       required this.backgroundButtonColor,
//       required this.foreButtonColor});
//   final CartItem product;
//   final double border;
//   Color backgroundButtonColor = const Color.fromARGB(255, 221, 230, 233);
//   Color foreButtonColor = const Color.fromARGB(255, 0, 0, 0);

//   @override
//   State<AddToCartButton> createState() => _AddToCartButtonState();
// }

// class _AddToCartButtonState extends State<AddToCartButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartProvider>(builder: (context, cart, child) {
//       return ElevatedButton(
//         onPressed: () {
//           final authProvider =
//               Provider.of<LoginProvider>(context, listen: false);
//           if (cart.cart == null){}
//           if (cart.isCartItemExist(widget.product)) {
//             cart.removeFromCart(widget.product.productId, authProvider.token);
//             // widget.product.stock +=
//             //     cartList.cartList[widget.product.id]!.quantity;
//             // Provider.of<ProductList>(context, listen: false)
//             //     .increaseProductQuantity(widget.product.id,
//             //         cartList.cartList[widget.product.id]!.quantity);
//             // cartList.removeAllItem(widget.product);
//           } else {
//             cart.addToCart(widget.product, authProvider.token);
//             // Provider.of<ProductList>(context, listen: false)
//             //     .decreaseProductQuantityByOne(widget.product.id);
//           }
//           // setState(() {
//           //   // widget.product.isAdded = !widget.product.isAdded;
//           // });
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: (cart.isCartItemExist(widget.product))
//               ? const Color.fromARGB(255, 122, 206, 203)
//               : widget.backgroundButtonColor,
//           shadowColor: const Color.fromARGB(255, 80, 80, 80),
//           foregroundColor: widget.foreButtonColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(widget.border),
//           ),
//         ),
//         child: (cart.isCartItemExist(widget.product))
//             ? const Text("Added To Cart")
//             : const Text("Add To Cart"),
//       );
//     });
//   }
// }

// class AddToCartButton extends StatefulWidget {
//   AddToCartButton(
//       {required this.product,
//       super.key,
//       required this.border,
//       required this.backgroundButtonColor,
//       required this.foreButtonColor});
//   final CartItem product;
//   final double border;
//   Color backgroundButtonColor = const Color.fromARGB(255, 221, 230, 233);
//   Color foreButtonColor = const Color.fromARGB(255, 0, 0, 0);

//   @override
//   State<AddToCartButton> createState() => _AddToCartButtonState();
// }

// class _AddToCartButtonState extends State<AddToCartButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartProvider>(builder: (context, cart, child) {
//       // Guard against null cart
//       if (cart == null) {
//         return const Center(child: Text("Cart is not available"));
//       }

//       return ElevatedButton(
//         onPressed: () {
//           final authProvider =
//               Provider.of<LoginProvider>(context, listen: false);

//           if (cart.isCartItemExist(widget.product)) {
//             cart.removeFromCart(widget.product.productId, authProvider.token);
//           } else {
//             cart.addToCart(widget.product, authProvider.token);
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: (cart.isCartItemExist(widget.product))
//               ? const Color.fromARGB(255, 122, 206, 203)
//               : widget.backgroundButtonColor,
//           shadowColor: const Color.fromARGB(255, 80, 80, 80),
//           foregroundColor: widget.foreButtonColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(widget.border),
//           ),
//         ),
//         child: (cart.isCartItemExist(widget.product))
//             ? const Text("Added To Cart")
//             : const Text("Add To Cart"),
//       );
//     });
//   }
// }

// class AddToCartButton extends StatefulWidget {
//   AddToCartButton(
//       {required this.product,
//       super.key,
//       required this.border,
//       required this.backgroundButtonColor,
//       required this.foreButtonColor});
//   final CartItem product;
//   final double border;
//   Color backgroundButtonColor = const Color.fromARGB(255, 221, 230, 233);
//   Color foreButtonColor = const Color.fromARGB(255, 0, 0, 0);

//   @override
//   State<AddToCartButton> createState() => _AddToCartButtonState();
// }

// class _AddToCartButtonState extends State<AddToCartButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartProvider>(builder: (context, cart, child) {
//       return ElevatedButton(
//         onPressed: () {
//           final authProvider =
//               Provider.of<LoginProvider>(context, listen: false);

//           // Use addPostFrameCallback to ensure state is updated after build
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (cart.cart != null) {
//               if (cart.isCartItemExist(widget.product)) {
//                 cart.removeFromCart(
//                     widget.product.productId, authProvider.token);
//               } else {
//                 cart.addToCart(widget.product, authProvider.token);
//               }
//             } else {
//               cart.addToCart(widget.product, authProvider.token);
//             }
//           });
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: (cart.isCartItemExist(widget.product))
//               ? const Color.fromARGB(255, 122, 206, 203)
//               : widget.backgroundButtonColor,
//           shadowColor: const Color.fromARGB(255, 80, 80, 80),
//           foregroundColor: widget.foreButtonColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(widget.border),
//           ),
//         ),
//         child: (cart.isCartItemExist(widget.product))
//             ? const Text("Added To Cart")
//             : const Text("Add To Cart"),
//       );
//     });
//   }
// }

// class AddToCartButton extends StatefulWidget {
//   AddToCartButton(
//       {required this.product,
//       super.key,
//       required this.border,
//       required this.backgroundButtonColor,
//       required this.foreButtonColor});
//   final CartItem product;
//   final double border;
//   Color backgroundButtonColor = const Color.fromARGB(255, 221, 230, 233);
//   Color foreButtonColor = const Color.fromARGB(255, 0, 0, 0);

//   @override
//   State<AddToCartButton> createState() => _AddToCartButtonState();
// }

// class _AddToCartButtonState extends State<AddToCartButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartProvider>(builder: (context, cart, child) {
//       // Guard against null cart
//       if (cart == null) {
//         return const Center(child: Text("Cart is not available"));
//       }

//       return ElevatedButton(
//         onPressed: () {
//           final authProvider =
//               Provider.of<LoginProvider>(context, listen: false);

//           // Ensure cart is initialized before checking
//           if (cart.cart != null) {
//             if (cart.isCartItemExist(widget.product)) {
//               // Remove item from cart if it already exists
//               cart.removeFromCart(widget.product.productId, authProvider.token);
//             } else {
//               // Add item to cart if it doesn't exist
//               cart.addToCart(widget.product, authProvider.token);
//             }
//           } else {
//             // If cart is null, directly add the item
//             cart.addToCart(widget.product, authProvider.token);
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: (cart.isCartItemExist(widget.product))
//               ? const Color.fromARGB(255, 122, 206, 203)
//               : widget.backgroundButtonColor,
//           shadowColor: const Color.fromARGB(255, 80, 80, 80),
//           foregroundColor: widget.foreButtonColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(widget.border),
//           ),
//         ),
//         child: (cart.isCartItemExist(widget.product))
//             ? const Text("Added To Cart")
//             : const Text("Add To Cart"),
//       );
//     });
//   }
// }

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
            // if (cart == null || cart.cart == null) {
            cart.addToCart(widget.product, authProvider.token);
            // } else {
            //   if (cart.isCartItemExist(widget.product)) {
            //     // Remove item from cart if it already exists
            //     cart.removeFromCart(
            //         widget.product.productId, authProvider.token);
            //   }
            // }
            // Check if the cart is initialized and if product exists in the cart
            // if (cart.cart != null) {
            //   if (cart.isCartItemExist(widget.product)) {
            //     // Remove item from cart if it already exists
            //     cart.removeFromCart(
            //         widget.product.productId, authProvider.token);
            //   } else {
            //     // Add item to cart if it doesn't exist
            //     cart.addToCart(widget.product, authProvider.token);
            //   }
            // } else {
            //   // If the cart is not initialized, directly add item to cart
            //   cart.addToCart(widget.product, authProvider.token);
            // }
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
            // Check if the cart is initialized and if product exists in the cart
            // if (cart.cart != null) {
            //   if (cart.isCartItemExist(widget.product)) {
            //     // Remove item from cart if it already exists
            //     cart.removeFromCart(
            //         widget.product.productId, authProvider.token);
            //   } else {
            //     // Add item to cart if it doesn't exist
            //     cart.addToCart(widget.product, authProvider.token);
            //   }
            // } else {
            //   // If the cart is not initialized, directly add item to cart
            //   cart.addToCart(widget.product, authProvider.token);
            // }
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
