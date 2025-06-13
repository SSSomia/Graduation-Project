// import 'package:flutter/material.dart';
// import 'package:graduation_project/providers/login_provider.dart';
// import 'package:graduation_project/providers/seller_top_selling_prodcuts.dart';
// import 'package:graduation_project/widgets/top_product_list.dart';
// import 'package:provider/provider.dart';
// import '../../../providerNotUse/sales_provider.dart';
// import '../../../widgets/sales_summary_card.dart';

// class AnalyticsScreen extends StatefulWidget {
//   @override
//   State<AnalyticsScreen> createState() => _AnalyticsScreenState();
// }

// class _AnalyticsScreenState extends State<AnalyticsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final authProvider = Provider.of<LoginProvider>(context, listen: false);
//       final provider = Provider.of<TopSellingProvider>(context, listen: false);
//       provider.loadTopSellingProducts(authProvider.token);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final salesProvider =
//         context.watch<SalesProvider>(); // ✅ Safe way to access provider

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Analytics',
//           style: TextStyle(
//             color: Color.fromARGB(255, 0, 0, 0),
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: const Color.fromARGB(255, 244, 255, 254),
//         //  shadowColor: const Color.fromARGB(255, 252, 252, 252),
//         elevation: 10,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20)),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                     child: SalesSummaryCard(
//                   title: "Total Revenue",
//                   value: "\$${salesProvider.totalRevenue}",
//                   icon: Icons.monetization_on_outlined,
//                   color: const Color.fromARGB(255, 39, 167, 189),
//                   iconColor: const Color.fromARGB(255, 48, 119, 125),
//                 )),
//                 const SizedBox(width: 10),
//                 Expanded(
//                     child: SalesSummaryCard(
//                   title: "Total Orders",
//                   value: "${salesProvider.totalOrders}",
//                   icon: Icons.shopping_cart_outlined,
//                   color: const Color.fromARGB(255, 39, 167, 189),
//                   iconColor: const Color.fromARGB(255, 48, 119, 125),
//                 )),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                     child: SalesSummaryCard(
//                   title: "Total Profit",
//                   value: "\$${salesProvider.totalRevenue}",
//                   icon: Icons.monetization_on_outlined,
//                   color: const Color.fromARGB(255, 39, 167, 189),
//                   iconColor: const Color.fromARGB(255, 48, 119, 125),
//                 )),
//                 const SizedBox(width: 10),
//                 Expanded(
//                     child: SalesSummaryCard(
//                   title: "Total Cost",
//                   value: "\$${salesProvider.totalRevenue}",
//                   icon: Icons.monetization_on_outlined,
//                   color: const Color.fromARGB(255, 39, 167, 189),
//                   iconColor: const Color.fromARGB(255, 48, 119, 125),
//                 )),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                     child: SalesSummaryCard(
//                   title: "Completed",
//                   value: "${salesProvider.completedOrders}",
//                   icon: Icons.check_circle_outline_rounded,
//                   color: const Color.fromARGB(255, 39, 167, 189),
//                   iconColor: const Color.fromARGB(255, 48, 119, 125),
//                 )),
//                 const SizedBox(width: 10),
//                 Expanded(
//                     child: SalesSummaryCard(
//                   title: "Pending",
//                   value: "${salesProvider.pendingOrders}",
//                   icon: Icons.pending_outlined,
//                   color: const Color.fromARGB(255, 39, 167, 189),
//                   iconColor: const Color.fromARGB(255, 48, 119, 125),
//                 )),
//               ],
//             ),
//             const SizedBox(height: 20),
//             // SalesChart(),
//             // const SizedBox(height: 20),
//             // OrdersPieChart(),
//             Consumer<TopSellingProvider>(
//               builder: (context, provider, child) {
//                 if (provider.isLoading) {
//                   return CircularProgressIndicator();
//                 } else if (provider.error != null) {
//                   return Text('Error: ${provider.error}');
//                 } else {
//                   return ListView.builder(
//                     itemCount: provider.products.length,
//                     itemBuilder: (context, index) {
//                       final product = provider.products[index];
//                       return ListTile(
//                         leading: Image.network(product.imageUrl),
//                         title: Text(product.productName),
//                         subtitle: Text(
//                             '${product.unitsSold} sold - \$${product.revenue}'),
//                       );
//                     },
//                   );
//                 }
//               },
//             )

//             // TopProductsList(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_top_selling_prodcuts.dart';
import 'package:provider/provider.dart';
import '../../../providerNotUse/sales_provider.dart';
import '../../../widgets/sales_summary_card.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      final provider = Provider.of<TopSellingProvider>(context, listen: false);
      provider.loadTopSellingProducts(authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final salesProvider = context.watch<SalesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Analytics',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 255, 254),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Summary Cards Section
            Row(
              children: [
                Expanded(
                    child: SalesSummaryCard(
                  title: "Total Revenue",
                  value: "\$${salesProvider.totalRevenue}",
                  icon: Icons.monetization_on_outlined,
                  color: const Color.fromARGB(255, 39, 167, 189),
                  iconColor: const Color.fromARGB(255, 48, 119, 125),
                )),
                const SizedBox(width: 10),
                Expanded(
                    child: SalesSummaryCard(
                  title: "Total Orders",
                  value: "${salesProvider.totalOrders}",
                  icon: Icons.shopping_cart_outlined,
                  color: const Color.fromARGB(255, 39, 167, 189),
                  iconColor: const Color.fromARGB(255, 48, 119, 125),
                )),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: SalesSummaryCard(
                  title: "Total Profit",
                  value: "\$${salesProvider.totalRevenue}",
                  icon: Icons.monetization_on_outlined,
                  color: const Color.fromARGB(255, 39, 167, 189),
                  iconColor: const Color.fromARGB(255, 48, 119, 125),
                )),
                const SizedBox(width: 10),
                Expanded(
                    child: SalesSummaryCard(
                  title: "Total Cost",
                  value: "\$${salesProvider.totalRevenue}",
                  icon: Icons.monetization_on_outlined,
                  color: const Color.fromARGB(255, 39, 167, 189),
                  iconColor: const Color.fromARGB(255, 48, 119, 125),
                )),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: SalesSummaryCard(
                  title: "Completed",
                  value: "${salesProvider.completedOrders}",
                  icon: Icons.check_circle_outline_rounded,
                  color: const Color.fromARGB(255, 39, 167, 189),
                  iconColor: const Color.fromARGB(255, 48, 119, 125),
                )),
                const SizedBox(width: 10),
                Expanded(
                    child: SalesSummaryCard(
                  title: "Pending",
                  value: "${salesProvider.pendingOrders}",
                  icon: Icons.pending_outlined,
                  color: const Color.fromARGB(255, 39, 167, 189),
                  iconColor: const Color.fromARGB(255, 48, 119, 125),
                )),
              ],
            ),
            const SizedBox(height: 20),

            // // Top Selling Products
            // const Text(
            //   'Top Selling Products',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 10),
            Consumer<TopSellingProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (provider.error != null) {
                  return Text('Error: ${provider.error}');
                } else if (provider.products.isEmpty) {
                  return const Text('No top selling products found.');
                } else {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(60, 146, 255, 251),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Top Selling Products",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.products.length,
                          itemBuilder: (context, index) {
                            final product = provider.products[index];

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        product.imageUrl,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.productName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.sell,
                                                  size: 16, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Text('${product.unitsSold} sold'),
                                              const SizedBox(width: 12),
                                              const Icon(Icons.attach_money,
                                                  size: 16, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Text('\$${product.revenue}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Colors.teal[400],
                                      child: Text(
                                        '#${index + 1}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            )

            // Consumer<TopSellingProvider>(
            //   builder: (context, provider, child) {
            //     if (provider.isLoading) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (provider.error != null) {
            //       return Text('Error: ${provider.error}');
            //     } else if (provider.products.isEmpty) {
            //       return const Text('No top selling products found.');
            //     } else {
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         physics: NeverScrollableScrollPhysics(),
            //         itemCount: provider.products.length,
            //         itemBuilder: (context, index) {
            //           final product = provider.products[index];

            //           return Card(
            //             elevation: 3,
            //             margin: const EdgeInsets.symmetric(vertical: 8),
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(15)),
            //             child: Padding(
            //               padding: const EdgeInsets.all(12),
            //               child: Row(
            //                 children: [
            //                   // Product Image
            //                   ClipRRect(
            //                     borderRadius: BorderRadius.circular(10),
            //                     child: Image.network(
            //                       product.imageUrl,
            //                       width: 60,
            //                       height: 60,
            //                       fit: BoxFit.cover,
            //                     ),
            //                   ),
            //                   const SizedBox(width: 12),

            //                   // Product Info
            //                   Expanded(
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           product.productName,
            //                           style: TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 16,
            //                           ),
            //                         ),
            //                         const SizedBox(height: 6),
            //                         Row(
            //                           children: [
            //                             Icon(Icons.sell,
            //                                 size: 16, color: Colors.grey[600]),
            //                             const SizedBox(width: 4),
            //                             Text('${product.unitsSold} sold'),
            //                             const SizedBox(width: 12),
            //                             Icon(Icons.attach_money,
            //                                 size: 16, color: Colors.grey[600]),
            //                             const SizedBox(width: 4),
            //                             Text('${product.revenue}'),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   ),

            //                   // Rank Badge
            //                   CircleAvatar(
            //                     radius: 14,
            //                     backgroundColor: Colors.teal[400],
            //                     child: Text(
            //                       '#${index + 1}',
            //                       style: const TextStyle(
            //                           color: Colors.white, fontSize: 12),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       );

            //       // return ListView.builder(
            //       //   shrinkWrap: true, // ✅ Important to prevent layout errors
            //       //   physics:
            //       //       const NeverScrollableScrollPhysics(), // ✅ Disable nested scrolling
            //       //   itemCount: provider.products.length,
            //       //   itemBuilder: (context, index) {
            //       //     final product = provider.products[index];
            //       //     return Card(
            //       //       margin: const EdgeInsets.symmetric(vertical: 8),
            //       //       child: ListTile(
            //       //         leading: Image.network(
            //       //           product.imageUrl,
            //       //           width: 50,
            //       //           height: 50,
            //       //           fit: BoxFit.cover,
            //       //         ),
            //       //         title: Text(product.productName),
            //       //         subtitle: Text(
            //       //             '${product.unitsSold} sold - \$${product.revenue}'),
            //       //       ),
            //       //     );
            //       //   },
            //       // );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
