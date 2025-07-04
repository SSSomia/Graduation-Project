import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/orders_provider.dart';
import 'package:graduation_project/screens/customer/orders/order_details.dart';
import 'package:graduation_project/widgets/myDrawer.dart';
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

    // if (orderProvider.isLoading) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    // if (orders.isEmpty) {
    //   return const Scaffold(
    //     body: Center(child: Text("No orders added yet")),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        // leading: const Icon(Icons.shopping_bag_outlined),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
        //  shadowColor: const Color.fromARGB(255, 252, 252, 252),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
      body: (orderProvider.isLoading)
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : (orders.isEmpty)
              ? const Scaffold(
                  body: Center(child: Text("No orders added yet")),
                )
              : ListView.builder(
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
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Text(
                                  '${order.totalPrice.toStringAsFixed(2)} \$',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 132, 0, 0),
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
                                        builder: (context) => OrderDetailsPage(
                                            orderId: order.orderId),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "View Details",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 136, 40, 40)),
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
