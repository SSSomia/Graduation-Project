import 'package:flutter/material.dart';
import 'package:graduation_project/providers/buyer_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/screens/seller/addCoupon.dart';
import 'package:graduation_project/screens/seller/coupon_screen.dart';
import 'package:provider/provider.dart';

class BuyersPage extends StatefulWidget {
  @override
  State<BuyersPage> createState() => _BuyersPageState();
}

class _BuyersPageState extends State<BuyersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<BuyersProvider>(context, listen: false)
          .loadBuyers(authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Buyers'),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: Consumer<BuyersProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final buyers = provider.buyers;

          if (buyers.isEmpty) {
            return const Center(
              child: Text(
                "No buyers available.",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: buyers.length,
            itemBuilder: (context, index) {
              final buyer = buyers[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color.fromARGB(255, 215, 232, 230),
                        child: Text(
                          buyer.userName[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:const Color.fromARGB(255, 31, 120, 133)
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              buyer.userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Orders: ${buyer.ordersCount}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateCouponPage(
                                buyerId: buyer.userId,
                                buyerName: buyer.userName,
                              ),
                            ),
                          );
                          Navigator.pop(
                              context); // if you still want to go back after add
                        },
                        icon: const Icon(Icons.add,
                            color:  Color.fromARGB(255, 31, 120, 133)),
                        label: const Text('Add Coupon'),
                        style: TextButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 31, 120, 133),
                        ),
                      ),
                    ],
                  ),
                ),
              );

              // return Card(
              //   elevation: 3,
              //   margin: const EdgeInsets.symmetric(vertical: 8),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: ListTile(
              //     contentPadding: const EdgeInsets.all(16),
              //     leading: CircleAvatar(
              //       radius: 24,
              //       backgroundColor: Colors.indigo.shade100,
              //       child: Text(
              //         buyer.userName[0].toUpperCase(),
              //         style: const TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.indigo,
              //         ),
              //       ),
              //     ),
              //     title: Text(
              //       buyer.userName,
              //       style: const TextStyle(
              //         fontWeight: FontWeight.w600,
              //         fontSize: 16,
              //       ),
              //     ),
              //     subtitle: Text(
              //       'Orders: ${buyer.ordersCount}',
              //       style: const TextStyle(fontSize: 14, color: Colors.grey),
              //     ),
              //     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              //     onTap: () async {
              //       await Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => CreateCouponPage(
              //             buyerId: buyer.userId,
              //             buyerName: buyer.userName,
              //           ),
              //         ),
              //       );
              //       Navigator.pop(context);
              //     },
              //   ),
              // );
            },
          );
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('My Buyers'),
  //     ),
  //     body: Consumer<BuyersProvider>(
  //       builder: (context, provider, child) {
  //         if (provider.isLoading) {
  //           return const Center(child: CircularProgressIndicator());
  //         }

  //         final buyers = provider.buyers;

  //         if (buyers.isEmpty) {
  //           return const Center(child: Text("No buyers available."));
  //         }

  //         return ListView.builder(
  //           itemCount: provider.buyers.length,
  //           itemBuilder: (context, index) {
  //             final buyer = provider.buyers[index];
  //             return ListTile(
  //               leading: CircleAvatar(
  //                 child: Text(buyer.userName[0].toUpperCase()),
  //               ),
  //               title: Text(buyer.userName),
  //               subtitle: Text('Orders: ${buyer.ordersCount}'),
  //               onTap: () async{
  //                 await Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) =>
  //                         CreateCouponPage( buyerId: buyer.userId, buyerName: buyer.userName,),
  //                   ),
  //                 );
  //                 Navigator.pop(context);
  //               },
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
}
