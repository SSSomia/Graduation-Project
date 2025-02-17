// i will take the card design
// make a provider for the order list
// modifiy the card of unused things
import 'package:graduation_project/pages/orders/order_details.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/pages/orders/order_list.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  Orders({super.key});

  @override
  Widget build(BuildContext context) {
    final _orderList = Provider.of<OrderList>(context);

    return _orderList.orderList.isEmpty
        ? const Scaffold(body: Center(child: Text("no orders added yet")))
        : Scaffold(
            body: ListView.builder(
              itemCount: _orderList.orderList.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final order = _orderList.orderList['$index'];
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
                              order!.orderId,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy hh:mm a')
                                  .format(order.dateTime),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Status
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 10,
                              //color: _getStatusColor(order["status"]),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              order.status,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                // color: _getStatusColor(order["status"]),
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Text(
                              order.totalPrice.toStringAsFixed(2),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // View details action
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderDetailsPage(orderId: order.orderId,)));
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

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case "Delivered":
//         return Colors.green;
//       case "Shipped":
//         return Colors.orange;
//       case "Processing":
//         return Colors.blue;
//       case "Cancelled":
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
// }
