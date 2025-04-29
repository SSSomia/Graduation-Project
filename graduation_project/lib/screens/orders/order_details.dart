// // import 'package:flutter/material.dart';
// // import 'package:graduation_project/pages/product_page/product_module.dart';

// // class OrderDetailsPage extends StatelessWidget {
// //   final Map<String, Product> orderDetails;

// //   const OrderDetailsPage({super.key, required this.orderDetails});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Order Details"),
// //         backgroundColor: Colors.blueAccent,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             _buildDetailTile("Order ID", orderDetails["orderId"] as String),
// //             _buildDetailTile("Customer Name", orderDetails["customerName"] as String),
// //             _buildDetailTile("Total Price", "\$${orderDetails["totalPrice"]}"),
// //             _buildDetailTile("Order Status", orderDetails["status"] as String),
// //             const SizedBox(height: 20),
// //             const Text("Ordered Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //             Expanded(
// //               child: ListView.builder(
// //                 itemCount: orderDetails.length,
// //                 itemBuilder: (context, index) {
// //                   final item = orderDetails["items"][index];
// //                   return Card(
// //                     margin: const EdgeInsets.symmetric(vertical: 5),
// //                     child: ListTile(
// //                       leading: const Icon(Icons.shopping_bag, color: Colors.blue),
// //                       title: Text(item["name"]),
// //                       subtitle: Text("Quantity: ${item["quantity"]}"),
// //                       trailing: Text("\$${item["price"]}"),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDetailTile(String title, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //           Text(value, style: const TextStyle(fontSize: 16, color: Colors.blue)),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // void printOrders() {
// //   orderList.forEach((orderId, order) {
// //     print("Order ID: $orderId");
// //     print("Total Price: ${order.totalPrice}");
// //     print("Products in this order:");

// //     for (var item in order.orderItems.values) {
// //       print(
// //           "- ${item.product.productName} | Quantity: ${item.quantity} | Price: ${item.price}");
// //     }
// //   });
// // }

// import 'package:flutter/material.dart';
// import 'package:graduation_project/providers/order_list.dart';
// import 'package:graduation_project/screens/product/productPage.dart';
// import 'package:provider/provider.dart';

// class OrderDetailsPage extends StatelessWidget {
//   final orderId;

//   OrderDetailsPage({Key? key, required this.orderId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final orderList = Provider.of<OrderList>(context).orderList[orderId];
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order Details'),
//       ),
//       body: ListView.builder(
//         itemCount: orderList?.orderItems.length,
//         itemBuilder: (context, index) {
//           final product = orderList?.orderItems[index];
//           return Card(
//               margin: const EdgeInsets.all(8.0),
//               child: GestureDetector(
//                 onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ProductPage(
//                               product: product.product,
//                             ))),
//                 // shape: () => Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //       builder: (context) => ProductPage(
//                 //             product: item,
//                 //           ))),
//                 child: ListTile(
//                   leading: Image.network(product!.product.imageUrl[0],
//                       width: 50, height: 50, fit: BoxFit.cover),
//                   title: Text('${product.price}'),
//                   subtitle: Text(
//                       'Quantity: ${product.quantity}\nPrice: \$${product.price}'),
//                 ),
//               ));
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation_project/api_providers/login_provider.dart';
import 'package:graduation_project/api_providers/order_details_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// class OrderDetailsPage extends StatefulWidget {
//   final int orderId;

//   const OrderDetailsPage({super.key, required this.orderId});

//   @override
//   State<OrderDetailsPage> createState() => _OrderDetailsPageState();
// }

// class _OrderDetailsPageState extends State<OrderDetailsPage> {
//   @override
//   void initState() {
//     super.initState();

//     // Delay the load call to avoid build phase errors
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final authProvider = Provider.of<LoginProvider>(context, listen: false);

//       Provider.of<OrderDetailProvider>(context, listen: false)
//           .loadOrderDetails(widget.orderId, authProvider.token);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orderDetailProvider = Provider.of<OrderDetailProvider>(context);
//     final order = orderDetailProvider.orderDetails;
//     final isLoading = orderDetailProvider.isLoading;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order Details"),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : order == null
//               ? const Center(child: Text("Order not found"))
//               : Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Order ID: ${order.orderId}",
//                         style: const TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Date: ${DateFormat('dd/MM/yyyy hh:mm a').format(order.orderDate)}",
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         "Total: \$${order.totalPrice.toStringAsFixed(2)}",
//                         style: const TextStyle(
//                             fontSize: 16, color: Colors.blueAccent),
//                       ),
//                       const SizedBox(height: 24),
//                       const Text(
//                         "Items:",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: order.items.length,
//                           itemBuilder: (context, index) {
//                             final item = order.items[index];
//                             return ListTile(
//                               title: Text(item.productName),
//                               subtitle: Text("Quantity: ${item.quantity}"),
//                               trailing: Text(
//                                 "\$${item.price.toStringAsFixed(2)}",
//                                 style: const TextStyle(
//                                     color: Colors.green,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//     );
//   }
// }

class OrderDetailsPage extends StatefulWidget {
  final int orderId;

  const OrderDetailsPage({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();

    // Delay the load call to avoid build phase errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);

      Provider.of<OrderDetailProvider>(context, listen: false)
          .loadOrderDetails(widget.orderId, authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: const Color.fromARGB(255, 58, 163, 165),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(child: Text(provider.error!))
              : provider.details.isEmpty
                  ? const Center(child: Text('No order details found'))
                  : ListView.builder(
                      itemCount: provider.details.length,
                      itemBuilder: (context, index) {
                        final detail = provider.details[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: ListTile(
                            leading: Image.network(
                              detail.productImage,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(detail.productName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Quantity: ${detail.quantity}"),
                                Text("Unit Price: \$${detail.unitPrice}"),
                                Text("Subtotal: \$${detail.subtotal}"),
                                if (detail.discountPercentage != null)
                                  Text(
                                      "Discount: ${detail.discountPercentage!.toStringAsFixed(0)}%"),
                                if (detail.discountExpiryDate != null)
                                  Text(
                                    "Expires: ${detail.discountExpiryDate!.toLocal().toString().split(' ')[0]}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
