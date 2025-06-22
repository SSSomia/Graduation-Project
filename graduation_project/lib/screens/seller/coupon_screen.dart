import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_discount_provider.dart';
import 'package:graduation_project/screens/seller/my_buyers.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SellerCouponsPage extends StatefulWidget {
  const SellerCouponsPage({super.key});

  @override
  State<SellerCouponsPage> createState() => _SellerCouponsPageState();
}

class _SellerCouponsPageState extends State<SellerCouponsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<SellerDiscountProvider>(context, listen: false)
          .fetchDiscounts(authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Coupons',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Stack(
        children: [
          Container(
            height: 210,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 239, 114, 114),
                  Color.fromARGB(255, 141, 24, 24)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
            ),
          ),
          Center(
            child: Consumer<SellerDiscountProvider>(
                builder: (context, discountProvider, child) {
              if (discountProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final discounts = discountProvider.discounts;

              if (discounts.isEmpty) {
                return const Center(child: Text('No discounts available.'));
              }

              return ListView.builder(
                itemCount: discounts.length,
                itemBuilder: (context, index) {
                  final discount = discounts[index];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: 'Store: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: discount.store,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text.rich(
                                  TextSpan(
                                    text: 'User: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: discount.user,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text.rich(
                                  TextSpan(
                                    text: 'Coupon Code: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: discount.couponCode,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text.rich(
                                  TextSpan(
                                    text: 'Discount: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: '${discount.discountPercentage}%',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text.rich(
                                  TextSpan(
                                    text: 'Created: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: '${DateFormat.yMMMd().format(discount.createdAt)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text.rich(
                                  TextSpan(
                                    text: 'Expires: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${DateFormat.yMMMd().format(discount.expiryDate)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final confirm = await showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Delete Coupon'),
                                  content: const Text(
                                      'Are you sure you want to delete this coupon?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(ctx, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx, true),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                final authProvider = Provider.of<LoginProvider>(
                                    context,
                                    listen: false);
                                await Provider.of<SellerDiscountProvider>(
                                        context,
                                        listen: false)
                                    .deleteDiscount(
                                        authProvider.token, discount.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Coupon deleted successfully')),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                  // return Card(
                  //   margin:
                  //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   child: ListTile(
                  //     title: Text('Store: ${discount.store}'),
                  //     subtitle: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text('User: ${discount.user}'),
                  //         Text('Coupon Code: ${discount.couponCode}'),
                  //         Text('Discount: ${discount.discountPercentage}%'),
                  //         Text('Created: ${discount.createdAt.toLocal()}'),
                  //         Text('Expires: ${discount.expiryDate.toLocal()}'),
                  //       ],
                  //     ),
                  //     trailing: IconButton(
                  //       icon: const Icon(Icons.delete, color: Colors.red),
                  //       onPressed: () async {
                  //         final confirm = await showDialog(
                  //           context: context,
                  //           builder: (ctx) => AlertDialog(
                  //             title: const Text('Delete Coupon'),
                  //             content: const Text(
                  //                 'Are you sure you want to delete this coupon?'),
                  //             actions: [
                  //               TextButton(
                  //                 onPressed: () => Navigator.pop(ctx, false),
                  //                 child: const Text('Cancel'),
                  //               ),
                  //               TextButton(
                  //                 onPressed: () async {
                  //                   Navigator.pop(ctx, true);
                  //                   final authProvider =
                  //                       Provider.of<LoginProvider>(context,
                  //                           listen: false);
                  //                   await Provider.of<SellerDiscountProvider>(
                  //                           context,
                  //                           listen: false)
                  //                       .deleteDiscount(
                  //                           authProvider.token, discount.id);
                  //                   ScaffoldMessenger.of(context).showSnackBar(
                  //                     const SnackBar(
                  //                         content: Text(
                  //                             'Coupon deleted successfully')),
                  //                   );
                  //                 },
                  //                 child: const Text('Delete'),
                  //               ),
                  //             ],
                  //           ),
                  //         );

                  //         if (confirm == true) {
                  //           final authProvider = Provider.of<LoginProvider>(
                  //               context,
                  //               listen: false);
                  //           await Provider.of<SellerDiscountProvider>(context,
                  //                   listen: false)
                  //               .deleteDiscount(
                  //                   authProvider.token, discount.id);
                  //           ScaffoldMessenger.of(context).showSnackBar(
                  //             const SnackBar(
                  //                 content: Text('Coupon deleted successfully')),
                  //           );
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // );
                },
              );
            }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => BuyersPage()));
          // Re-fetch the discounts when returning from BuyersPage
          final authProvider =
              Provider.of<LoginProvider>(context, listen: false);
          Provider.of<SellerDiscountProvider>(context, listen: false)
              .fetchDiscounts(authProvider.token);
          setState(() {});
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'New Coupon',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 185, 25, 25),
        elevation: 4,
      ),
    );
  }
}
