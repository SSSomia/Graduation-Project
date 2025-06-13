import 'package:flutter/material.dart';
import 'package:graduation_project/models/product_module.dart';
import 'package:graduation_project/models/seller_product.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_product_provider.dart';
import 'package:graduation_project/screens/seller/product/seller_product_page.dart';
import 'package:graduation_project/screens/seller/product/update_product_screen.dart';
import 'package:graduation_project/widgets/build_image.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final ProductModule product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    //   final marketProvider = Provider.of<MarketProvider>(context, listen: false);
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SellerProductPage(productid: product.productId),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        // child: buildImage(product.imageUrls[0]),
                        child: product.imageUrls.isNotEmpty
                            ? buildImage(product.imageUrls[0])
                            : const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Category: ${product.categoryName}"),
                      Text("Price: \$${product.price.toStringAsFixed(2)}"),
                      Text("Stock: ${product.stockQuantity} available"),
                      Text("Description: ${product.description}",
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateProductScreen(product: product),
                          ),
                        );
                      },
                    ),
                    IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Save the outer context here
                          final scaffoldContext = context;

                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Confirm Deletion"),
                              content: const Text(
                                  "Are you sure you want to delete this product?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () async {
                                    Navigator.of(ctx)
                                        .pop(); // Close dialog immediately

                                    try {
                                      final authProvider =
                                          Provider.of<LoginProvider>(
                                              scaffoldContext,
                                              listen: false);
                                      final sellerProductProvider =
                                          Provider.of<SellerProductProvider>(
                                              scaffoldContext,
                                              listen: false);

                                      await sellerProductProvider.deleteProduct(
                                          authProvider.token,
                                          product.productId);

                                      sellerProductProvider
                                          .fetchMyProducts(authProvider.token);

                                      ScaffoldMessenger.of(scaffoldContext)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Deleted successfully')),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(scaffoldContext)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Error: ${e.toString()}')),
                                      );
                                    }
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            ),
                          );
                        }

                        // onPressed: () {
                        //   showDialog(
                        //     context: context,
                        //     builder: (ctx) => AlertDialog(
                        //       title: const Text("Confirm Deletion"),
                        //       content: const Text(
                        //           "Are you sure you want to delete this product?"),
                        //       actions: [
                        //         TextButton(
                        //           onPressed: () => Navigator.of(ctx).pop(),
                        //           child: const Text("Cancel"),
                        //         ),
                        //         ElevatedButton(
                        //           style: ElevatedButton.styleFrom(
                        //             backgroundColor: Colors.red,
                        //           ),
                        //           onPressed: () async {
                        //             try {
                        //               final authProvider = Provider.of<LoginProvider>(
                        //                   context,
                        //                   listen: false);
                        //               final sellerProductProvider =
                        //                   Provider.of<SellerProductProvider>(context,
                        //                       listen: false);

                        //               await sellerProductProvider.deleteProduct(
                        //                   authProvider.token, product.productId);
                        //               await sellerProductProvider
                        //                   .fetchMyProducts(authProvider.token);

                        //               ScaffoldMessenger.of(context).showSnackBar(
                        //                 SnackBar(
                        //                     content: Text('Deleted successfully')),
                        //               );
                        //               // Optionally, navigate back or refresh the UI
                        //             } catch (e) {
                        //               ScaffoldMessenger.of(context).showSnackBar(
                        //                 SnackBar(
                        //                     content: Text('Error: ${e.toString()}')),
                        //               );
                        //             }
                        //           },
                        //           child: const Text("Delete"),
                        //         ),
                        //       ],
                        //     ),
                        //   );
                        // },
                        ),
                  ],
                )
              ],
            ),
          ),
        ));

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       elevation: 4,
//       child: ListTile(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     SellerProductPage(productid: product.productId)),
//           );
//         },
//         leading: CircleAvatar(
//           radius: 60,
//           backgroundColor: Colors.grey[200],
//           child: ClipOval(
//             child: SizedBox(
//               width: 120, // 2 * radius
//               height: 120,
//               child: FittedBox(
//                 fit: BoxFit.cover,
//                 child: buildImage(product.imageUrls[0]),
//               ),
//             ),
//           ),
//         ),
//         title: Text(product.name,
//             style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Category: ${product.categoryName}"),
//             Text("Price: \$${product.price.toStringAsFixed(2)}"),
//             Text("Stock: ${product.stockQuantity} available"),
//             Text("Description: ${product.description}",
//                 maxLines: 2, overflow: TextOverflow.ellipsis),
//           ],
//         ),
//         // trailing: IconButton(
//         //   icon: const Icon(Icons.mode_edit_outline_outlined),
//         //   onPressed: () {
//         //     Navigator.push(
//         //       context,
//         //       MaterialPageRoute(
//         //         builder: (context) => UpdateProductScreen(product: product),
//         //       ),
//         //     );
//         //   },
//         // ),
//         trailing: Column(
//   mainAxisSize: MainAxisSize.min, // <--- This avoids overflow
//   children: [
//     IconButton(
//       icon: const Icon(Icons.mode_edit_outline_outlined),
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => UpdateProductScreen(product: product),
//           ),
//         );
//       },
//     ),
//     IconButton(
//       icon: const Icon(Icons.delete_outline, color: Colors.red),
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text("Confirm Deletion"),
//             content: const Text("Are you sure you want to delete this product?"),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(ctx).pop(),
//                 child: const Text("Cancel"),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                 ),
//                 onPressed: () {
//                   Navigator.of(ctx).pop();
//                   // TODO: Add delete logic here
//                 },
//                 child: const Text("Delete"),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   ],
// ),

//       ),
//     );
  }
}
