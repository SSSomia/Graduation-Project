// // i will take the card design
// // make a provider for the order list
// // // modifiy the card of unused things

import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/order_details_model.dart';
import 'package:graduation_project/api_providers/login_provider.dart';
import 'package:graduation_project/api_providers/orders_provider.dart';
import 'package:graduation_project/screens/orders/order_details.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    super.initState();
    // Schedule the API call after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<OrderProvider>(context, listen: false)
          .loadUserOrders(authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final orders = orderProvider.orders;

    if (orderProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (orders.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No orders added yet")),
      );
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: orders.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final order = orders[orders.length - index - 1];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order ID and Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${order.orderId}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy hh:mm a')
                            .format(order.orderDate),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Total Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        '${order.totalPrice.toStringAsFixed(2)} \$',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // View Details Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailsPage(orderId: order.orderId),
                            ),
                          );
                        },
                        child: const Text(
                          "View Details",
                          style: TextStyle(
                              color: Color.fromARGB(255, 33, 115, 166)),
                        ),
                      ),
                    ],
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







// class Orders extends StatefulWidget {
//   const Orders({super.key});

//   @override
//   State<Orders> createState() => _OrdersState();
// }

// class _OrdersState extends State<Orders> {
//   bool _isInit = true;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (_isInit) {
//       final authProvider = Provider.of<LoginProvider>(context, listen: false);
//       Provider.of<OrderProvider>(context, listen: false)
//           .loadUserOrders(authProvider.token);
//       _isInit = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orderProvider = Provider.of<OrderProvider>(context);
//     final orders = orderProvider.orders;

//     if (orderProvider.isLoading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (orders.isEmpty) {
//       return const Scaffold(
//         body: Center(child: Text("No orders added yet")),
//       );
//     }

//     return Scaffold(
//       body: ListView.builder(
//         itemCount: orders.length,
//         padding: const EdgeInsets.all(16),
//         itemBuilder: (context, index) {
//           final order = orders[orders.length - index - 1];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Order ID and Date
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Order #${order.orderId}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         DateFormat('dd/MM/yyyy hh:mm a')
//                             .format(order.orderDate),
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),

//                   // Status
//                   const Row(
//                     children: [
//                       // Icon(
//                       //   Icons.circle,
//                       //   size: 10,
//                       //   color: Colors.green,
//                       // ),
//                       SizedBox(width: 8),
//                       // Text(
//                       //   order.status,
//                       //   style: const TextStyle(
//                       //     fontSize: 14,
//                       //     fontWeight: FontWeight.w600,
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),

//                   // Total Amount
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Total",
//                         style: TextStyle(fontSize: 14, color: Colors.grey),
//                       ),
//                       Text(
//                         '${order.totalPrice.toStringAsFixed(2)} \$',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),

//                   // Action Buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) =>
//                           //         OrderDetailsPage(orderId: order.orderId),
//                           //   ),
//                           // );
//                         },
//                         child: const Text(
//                           "View Details",
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 33, 115, 166)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

























// import 'package:graduation_project/screens/orders/order_details.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/providers/order_list.dart';
// import 'package:provider/provider.dart';

// class Orders extends StatelessWidget {
//   Orders({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final _orderList = Provider.of<OrderList>(context);
//     int numberOfOrders = _orderList.orderList.length;
//     return _orderList.orderList.isEmpty
//         ? const Scaffold(body: Center(child: Text("no orders added yet")))
//         : Scaffold(
//             body: ListView.builder(
//               itemCount: numberOfOrders,
//               padding: const EdgeInsets.all(16),
//               itemBuilder: (context, index) {
//                 final order = _orderList.orderList['${numberOfOrders - index - 1}'];
//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Order ID and Date
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               order!.orderId,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               DateFormat('dd/MM/yyyy hh:mm a')
//                                   .format(order.dateTime),
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),

//                         // Status
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.circle,
//                               size: 10,
//                               //color: _getStatusColor(order["status"]),
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               order.status,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 // color: _getStatusColor(order["status"]),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),

//                         // Total Amount
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Total",
//                               style:
//                                   TextStyle(fontSize: 14, color: Colors.grey),
//                             ),
//                             Text(
//                               order.totalPrice.toStringAsFixed(2) + " \$",
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blueAccent,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),

//                         // Action Buttons
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () {
//                                 // View details action
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => OrderDetailsPage(orderId: order.orderId,)));
//                               },
//                               child: const Text(
//                                 "View Details",
//                                 style: TextStyle(
//                                     color: Color.fromARGB(255, 33, 115, 166)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//   }
// }

// //   Color _getStatusColor(String status) {
// //     switch (status) {
// //       case "Delivered":
// //         return Colors.green;
// //       case "Shipped":
// //         return Colors.orange;
// //       case "Processing":
// //         return Colors.blue;
// //       case "Cancelled":
// //         return Colors.red;
// //       default:
// //         return Colors.grey;
// //     }
// //   }
// // }


// import 'package:flutter/material.dart';

// class Orders extends StatelessWidget {
//   const Orders({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }