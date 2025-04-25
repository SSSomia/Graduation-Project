// import 'package:flutter/material.dart';
// import 'package:graduation_project/api_models/product_module.dart';
// import 'package:graduation_project/providers/cart_list.dart';
// import 'package:graduation_project/screens/product/productPage.dart';
// import 'package:graduation_project/product_list/product_list.dart';
// import 'package:graduation_project/models/product_module.dart';
// import 'package:provider/provider.dart';

// class ListTileItem extends StatelessWidget {
//   final ProductModule
//       item; // Define the type of item as CartItem (or appropriate type)

//   const ListTileItem({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartList>(
//       builder: (context, cartItem, child) {
//         final orderItem = cartItem.cartList[item.productId];
//         return ListTile(
//           onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ProductPage(
//                         product: item,
//                       ))),
//           leading: CircleAvatar(
//             backgroundImage: NetworkImage(item.imageUrls[0]),
//           ),
//           title: Text(item.name),
//           subtitle: Text("Price: \$${item.price.toStringAsFixed(2)}"),
//           // trailing: Row(
//           //   mainAxisSize: MainAxisSize.min,
//           //   children: [
//           //     IconButton(
//           //       icon: const Icon(Icons.remove),
//           //       onPressed: () {
//           //         cartItem.removeItem(item);
//           //         Provider.of<ProductList>(context, listen: false)
//           //             .increaseProductQuantityByOne(item.id);
//           //       },
//           //     ),
//           //     Text("${orderItem!.quantity}"),
//           //     IconButton(
//           //       icon: const Icon(Icons.add),
//           //       onPressed: () {
//           //         cartItem.addItem(item);
//           //         Provider.of<ProductList>(context, listen: false)
//           //             .decreaseProductQuantityByOne(item.id);
//           //       },
//           //     ),
//           //   ],
//           // ),
//         );
//       },
//     );
//   }
// }
