import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/order_details_provider.dart';
import 'package:graduation_project/widgets/track_order_widget.dart';
import 'package:provider/provider.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<OrderDetailProvider>(context, listen: false)
          .loadOrderDetails(widget.orderId, authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderDetailProvider>(context);
    final authProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Details'),
          backgroundColor: const Color.fromARGB(255, 247, 225, 225),
        ),
        body: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.error != null
                ? Center(child: Text(provider.error!))
                :
                // Column(
                //     children: [
                //       Expanded(
                //         child: SingleChildScrollView(
                //           padding: const EdgeInsets.all(12),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               ...provider.details.map((detail) => Card(
                //                     margin:
                //                         const EdgeInsets.symmetric(vertical: 8),
                //                     child: ListTile(
                //                       leading: Image.network(
                //                         detail.productImage,
                //                         width: 50,
                //                         height: 50,
                //                         fit: BoxFit.cover,
                //                       ),
                //                       title: Text(detail.productName),
                //                       subtitle: Column(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           Text("Quantity: ${detail.quantity}"),
                //                           Text(
                //                               "Original Price: \$${detail.originalPrice.toStringAsFixed(2)}"),
                //                           Text(
                //                               "Final Price: \$${detail.finalPrice.toStringAsFixed(2)}"),
                //                           Text(
                //                               "Subtotal: \$${detail.subtotal.toStringAsFixed(2)}"),
                //                         ],
                //                       ),
                //                     ),
                //                   )),
                //               const SizedBox(height: 16),
                //               if (provider.status == "Shipped")
                //                 Center(
                //                   child: ElevatedButton(
                //                     onPressed: () async {
                //                       await provider.confirmDelivery(
                //                         widget.orderId,
                //                         authProvider.token,
                //                       );
                //                     },
                //                     style: ElevatedButton.styleFrom(
                //                         backgroundColor: Colors.green),
                //                     child: const Text("Confirm Delivery"),
                //                   ),
                //                 ),
                //             ],
                //           ),
                //         ),
                //       ),

                //       // ✅ BOTTOM: Track Order
                //       Container(
                //         padding: const EdgeInsets.all(12),
                //         decoration: BoxDecoration(
                //           color: Colors.teal.shade50,
                //           border: const Border(
                //             top: BorderSide(color: Colors.teal, width: 1),
                //           ),
                //         ),
                //         child: TrackOrderPage(
                //           orderId: widget.orderId,
                //           token: authProvider.token,
                //         ),
                //       ),
                //     ],
                //   ),
                Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...provider.details.map((detail) => Card(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      leading: Image.network(
                                        detail.productImage,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(detail.productName),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Quantity: ${detail.quantity}"),
                                          Text(
                                              "Original Price: \$${detail.originalPrice.toStringAsFixed(2)}"),
                                          Text(
                                              "Final Price: \$${detail.finalPrice.toStringAsFixed(2)}"),
                                          Text(
                                              "Subtotal: \$${detail.subtotal.toStringAsFixed(2)}"),
                                        ],
                                      ),
                                    ),
                                  )),
                              const SizedBox(height: 16),
                              if (provider.status == "Shipped")
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await provider.confirmDelivery(
                                          widget.orderId, authProvider.token);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    child: const Text("Confirm Delivery"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // ✅ Fix this: Constrained height
                      SizedBox(
                        height: 250,
                        child: TrackOrderPage(
                          orderId: widget.orderId,
                          token: authProvider.token,
                        ),
                      ),
                    ],
                  ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   final provider = Provider.of<OrderDetailProvider>(context);
  //   final authProvider = Provider.of<LoginProvider>(context, listen: false);

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Order Details'),
  //       backgroundColor: const Color.fromARGB(255, 58, 163, 165),
  //     ),
  //     body: provider.isLoading
  //         ? const Center(child: CircularProgressIndicator())
  //         : provider.error != null
  //             ? Center(child: Text(provider.error!))
  //             : ListView(
  //                 padding: const EdgeInsets.all(12),
  //                 children: [
  //                   // Row(
  //                   //   children: [
  //                   //     const Text("Order Status: ",
  //                   //         style: TextStyle(
  //                   //             fontSize: 16, fontWeight: FontWeight.bold)),
  //                   //     Text(
  //                   //       provider.status,
  //                   //       style: TextStyle(
  //                   //         fontSize: 16,
  //                   //         color: provider.status == "Shipped"
  //                   //             ? Colors.orange
  //                   //             : Colors.green,
  //                   //       ),
  //                   //     ),
  //                   //   ],
  //                   // ),
  //                   // const SizedBox(height: 10),

  //                   // const Divider(),

  //                   ...provider.details.map((detail) => Card(
  //                         margin: const EdgeInsets.symmetric(vertical: 8),
  //                         child: ListTile(
  //                           leading: Image.network(detail.productImage,
  //                               width: 50, height: 50),
  //                           title: Text(detail.productName),
  //                           subtitle: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text("Quantity: ${detail.quantity}"),
  //                               Text(
  //                                   "Original Price: \$${detail.originalPrice.toStringAsFixed(2)}"),
  //                               Text(
  //                                   "Final Price: \$${detail.finalPrice.toStringAsFixed(2)}"),
  //                               Text(
  //                                   "Subtotal: \$${detail.subtotal.toStringAsFixed(2)}"),
  //                             ],
  //                           ),
  //                         ),
  //                       )),

  //                   const SizedBox(height: 16),
  //                   if (provider.status == "Shipped")
  //                     ElevatedButton(
  //                       onPressed: () async {
  //                         await provider.confirmDelivery(
  //                           widget.orderId,
  //                           authProvider.token,
  //                         );
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: Colors.green),
  //                       child: const Text("Confirm Delivery"),
  //                     ),

  //                   /// Wrap this to avoid layout errors
  //                   SizedBox(
  //                     height: 200, // adjust based on what's inside
  //                     child: TrackOrderPage(
  //                       orderId: widget.orderId,
  //                       token: authProvider.token,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //   );
  // }
}
