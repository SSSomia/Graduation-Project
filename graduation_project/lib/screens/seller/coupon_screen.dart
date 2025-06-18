import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_discount_provider.dart';
import 'package:graduation_project/screens/seller/my_buyers.dart';
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
                  Color.fromARGB(255, 115, 201, 209),
                  Color.fromARGB(255, 30, 123, 131)
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
                    child: ListTile(
                      title: Text('Store: ${discount.store}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User: ${discount.user}'),
                          Text('Coupon Code: ${discount.couponCode}'),
                          Text('Discount: ${discount.discountPercentage}%'),
                          Text('Created: ${discount.createdAt.toLocal()}'),
                          Text('Expires: ${discount.expiryDate.toLocal()}'),
                        ],
                      ),
                      trailing: IconButton(
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
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(ctx, true);
                                    final authProvider =
                                        Provider.of<LoginProvider>(context,
                                            listen: false);
                                    await Provider.of<SellerDiscountProvider>(
                                            context,
                                            listen: false)
                                        .deleteDiscount(
                                            authProvider.token, discount.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Coupon deleted successfully')),
                                    );
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            final authProvider = Provider.of<LoginProvider>(
                                context,
                                listen: false);
                            await Provider.of<SellerDiscountProvider>(context,
                                    listen: false)
                                .deleteDiscount(
                                    authProvider.token, discount.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Coupon deleted successfully')),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()async {
        await  Navigator.push(
              context, MaterialPageRoute(builder: (_) => BuyersPage()));
          // Re-fetch the discounts when returning from BuyersPage
          final authProvider =
              Provider.of<LoginProvider>(context, listen: false);
          Provider.of<SellerDiscountProvider>(context, listen: false)
              .fetchDiscounts(authProvider.token);
          setState(() {});
        },
        icon: const Icon(Icons.add),
        label: const Text('New Coupon'),
        backgroundColor: const Color.fromARGB(255, 62, 196, 174),
        elevation: 4,
      ),
    );
  }
}
