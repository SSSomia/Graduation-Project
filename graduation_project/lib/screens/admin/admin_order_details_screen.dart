// import 'package:flutter/material.dart';
// import 'package:graduation_project/providers/login_provider.dart';
// import 'package:provider/provider.dart';
// import '../../providers/admin_order_details_provider.dart';

// class AdminOrderDetailsScreen extends StatefulWidget {
//   const AdminOrderDetailsScreen({
//     super.key,
//   });

//   @override
//   State<AdminOrderDetailsScreen> createState() =>
//       _AdminOrderDetailsScreenState();
// }

// class _AdminOrderDetailsScreenState extends State<AdminOrderDetailsScreen> {
//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final token = Provider.of<LoginProvider>(context, listen: false).token;
//       Provider.of<AdminOrderDetailsProvider>(context, listen: false)
//           .loadOrders(token);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Admin Order Overview')),
//       body: Consumer<AdminOrderDetailsProvider>(
//         builder: (context, provider, _) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (provider.orders.isEmpty) {
//             return const Center(child: Text('No orders found.'));
//           }
//           return ListView.builder(
//             itemCount: provider.orders.length,
//             itemBuilder: (context, index) {
//               final order = provider.orders[index];
//               return Card(
//                 margin: const EdgeInsets.all(8),
//                 child: ExpansionTile(
//                   title: Text('Order #${order.orderId} - ${order.status}'),
//                   subtitle: Text('Customer: ${order.customer.fullName}'),
//                   children: [
//                     ListTile(
//                       title: Text(order.customer.address),
//                       subtitle: Text(order.customer.phone),
//                     ),
//                     ...order.products.map((p) => ListTile(
//                           leading:
//                               Image.network(p.imageUrl, width: 50, height: 50),
//                           title: Text(p.name),
//                           trailing: Text('x${p.quantity}'),
//                         )),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Total After Discount: \$${order.totalAfterDiscount}',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/widgets/adminDrawer.dart';
import 'package:provider/provider.dart';
import '../../providers/admin_order_details_provider.dart';

class AdminOrderDetailsScreen extends StatefulWidget {
  const AdminOrderDetailsScreen({super.key});

  @override
  State<AdminOrderDetailsScreen> createState() =>
      _AdminOrderDetailsScreenState();
}

class _AdminOrderDetailsScreenState extends State<AdminOrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Provider.of<LoginProvider>(context, listen: false).token;
      Provider.of<AdminOrderDetailsProvider>(context, listen: false)
          .loadOrders(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      endDrawer: Admindrawer(),
      appBar: AppBar(
        title: const Text(
          'Orders Overview',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 250, 250),
        leading: const Icon(Icons.shopping_bag_outlined),
      ),
      body: Consumer<AdminOrderDetailsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.orders.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.orders.length,
            itemBuilder: (context, index) {
              final order = provider.orders[index];

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  tilePadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  childrenPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${order.orderId}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: order.status == 'Shipped'
                              ? Colors.green.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          order.status,
                          style: TextStyle(
                            color: order.status == 'Shipped'
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  children: [
                    /// Customer Info
                    Row(
                      children: [
                        const Icon(Icons.person_outline, size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(order.customer.fullName),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 20),
                        const SizedBox(width: 6),
                        Text(order.customer.phone),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 20),
                        const SizedBox(width: 6),
                        Expanded(child: Text(order.customer.address)),
                      ],
                    ),

                    const Divider(height: 24),

                    /// Product List
                    Column(
                      children: order.products.map((product) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  product.imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image, size: 50),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(product.name,
                                    style: const TextStyle(fontSize: 14)),
                              ),
                              Text('x${product.quantity}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    const Divider(height: 24),

                    /// Total

                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Total After Discount:   ${order.totalAfterDiscount}EGP',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 139, 30, 30),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );

          // return ListView.builder(
          //   padding: const EdgeInsets.all(12),
          //   itemCount: provider.orders.length,
          //   itemBuilder: (context, index) {
          //     final order = provider.orders[index];

          //     return Card(
          //       elevation: 3,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(16)),
          //       margin: const EdgeInsets.symmetric(vertical: 10),
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             /// Order Header
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   'Order #${order.orderId}',
          //                   style: const TextStyle(
          //                       fontWeight: FontWeight.bold, fontSize: 16),
          //                 ),
          //                 Container(
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 10, vertical: 5),
          //                   decoration: BoxDecoration(
          //                     color: order.status == 'Shipped'
          //                         ? Colors.green.withOpacity(0.1)
          //                         : Colors.orange.withOpacity(0.1),
          //                     borderRadius: BorderRadius.circular(20),
          //                   ),
          //                   child: Text(
          //                     order.status,
          //                     style: TextStyle(
          //                       color: order.status == 'Shipped'
          //                           ? Colors.green
          //                           : Colors.orange,
          //                       fontWeight: FontWeight.w600,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),

          //             const SizedBox(height: 12),

          //             /// Customer Info
          //             Row(
          //               children: [
          //                 const Icon(Icons.person_outline, size: 20),
          //                 const SizedBox(width: 6),
          //                 Expanded(
          //                   child: Text(
          //                     order.customer.fullName,
          //                     style: const TextStyle(fontSize: 14),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             Row(
          //               children: [
          //                 const Icon(Icons.phone, size: 20),
          //                 const SizedBox(width: 6),
          //                 Text(order.customer.phone),
          //               ],
          //             ),
          //             Row(
          //               children: [
          //                 const Icon(Icons.location_on_outlined, size: 20),
          //                 const SizedBox(width: 6),
          //                 Expanded(child: Text(order.customer.address)),
          //               ],
          //             ),

          //             const Divider(height: 24),

          //             /// Product List
          //             Column(
          //               children: order.products.map((product) {
          //                 return Padding(
          //                   padding: const EdgeInsets.symmetric(vertical: 6),
          //                   child: Row(
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       ClipRRect(
          //                         borderRadius: BorderRadius.circular(8),
          //                         child: Image.network(
          //                           product.imageUrl,
          //                           width: 50,
          //                           height: 50,
          //                           fit: BoxFit.cover,
          //                           errorBuilder: (context, error, stackTrace) =>
          //                               const Icon(Icons.broken_image, size: 50),
          //                         ),
          //                       ),
          //                       const SizedBox(width: 12),
          //                       Expanded(
          //                         child: Text(product.name,
          //                             style: const TextStyle(fontSize: 14)),
          //                       ),
          //                       Text('x${product.quantity}',
          //                           style: const TextStyle(
          //                               fontWeight: FontWeight.bold)),
          //                     ],
          //                   ),
          //                 );
          //               }).toList(),
          //             ),

          //             const Divider(height: 24),

          //             /// Total
          //             Align(
          //               alignment: Alignment.centerRight,
          //               child: Text(
          //                 'Total After Discount: \$${order.totalAfterDiscount}',
          //                 style: const TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 16,
          //                   color: Colors.deepPurple,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
