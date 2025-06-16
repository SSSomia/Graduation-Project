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
      ),
      body: Consumer<BuyersProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final buyers = provider.buyers;

          if (buyers.isEmpty) {
            return const Center(child: Text("No buyers available."));
          }

          return ListView.builder(
            itemCount: provider.buyers.length,
            itemBuilder: (context, index) {
              final buyer = provider.buyers[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(buyer.userName[0].toUpperCase()),
                ),
                title: Text(buyer.userName),
                subtitle: Text('Orders: ${buyer.ordersCount}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateCouponPage( buyerId: buyer.userId, buyerName: buyer.userName,),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
