// import 'package:flutter/material.dart';
// import 'package:graduation_project/providers/login_provider.dart';
// import 'package:graduation_project/providers/seller_order_product_provider.dart';
// import 'package:provider/provider.dart';

// class OrderProductsPage extends StatefulWidget {
//   final int orderId;

//   const OrderProductsPage({Key? key, required this.orderId}) : super(key: key);

//   @override
//   State<OrderProductsPage> createState() => _OrderProductsPageState();
// }

// class _OrderProductsPageState extends State<OrderProductsPage> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final authProvider = Provider.of<LoginProvider>(context, listen: false);
//       Provider.of<OrderProductsProvider>(context, listen: false)
//           .loadProducts(authProvider.token, widget.orderId);
//     });
//   }

//   void _changeOrderStatus(BuildContext context, int newStatus) async{
//     final authProvider = Provider.of<LoginProvider>(context, listen: false);
//     final provider = Provider.of<OrderProductsProvider>(context, listen: false);

//    await provider
//         .updateOrderStatus(widget.orderId, newStatus, authProvider.token)
//         .then((_) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Order status updated')),
//       );
//     Navigator.pop(context, true);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<OrderProductsProvider>(context);

//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Order #${widget.orderId} Products'),
//         ),
//         body: provider.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : provider.products.isEmpty
//                 ? const Center(child: Text('No products in this order.'))
//                 : Column(children: [
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: provider.products.length,
//                         itemBuilder: (context, index) {
//                           final product = provider.products[index];
//                           return ListTile(
//                             leading: CircleAvatar(
//                                 child: Text(product.productId.toString())),
//                             title: Text(product.productName),
//                             subtitle: Text('Qty: ${product.quantity}'),
//                             trailing: Text(
//                                 '${product.unitPrice.toStringAsFixed(2)} EGP'),
//                           );
//                         },
//                       ),
//                     ),
//                     const Divider(),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           ElevatedButton(
//                             onPressed: () => _changeOrderStatus(context, 0),
//                             child: const Text('Set Pending'),
//                           ),
//                           ElevatedButton(
//                             onPressed: () => _changeOrderStatus(context, 1),
//                             child: const Text('Set Shipped'),
//                           ),
//                           ElevatedButton(
//                             onPressed: () => _changeOrderStatus(context, 2),
//                             child: const Text('Set Canceled'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]));
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_order_product_provider.dart';
import 'package:provider/provider.dart';

class OrderProductsPage extends StatefulWidget {
  final int orderId;

  const OrderProductsPage({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderProductsPage> createState() => _OrderProductsPageState();
}

class _OrderProductsPageState extends State<OrderProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<OrderProductsProvider>(context, listen: false)
          .loadProducts(authProvider.token, widget.orderId);
    });
  }

  void _changeOrderStatus(BuildContext context, int newStatus) async {
    final authProvider = Provider.of<LoginProvider>(context, listen: false);
    final provider = Provider.of<OrderProductsProvider>(context, listen: false);

    await provider
        .updateOrderStatus(widget.orderId, newStatus, authProvider.token)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order status updated')),
      );
      Navigator.pop(context, true); // Refresh previous page
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${widget.orderId} Products'),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.products.isEmpty
              ? const Center(child: Text('No products in this order.'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: provider.products.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final product = provider.products[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 3,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                child: Text(
                                  product.productId.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(product.productName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              subtitle:
                                  Text('Qty: ${product.quantity.toString()}'),
                              trailing: Text(
                                '${product.unitPrice.toStringAsFixed(2)} EGP',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Change Order Status',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            // spacing: 12,
                            // runSpacing: 8,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _changeOrderStatus(context, 0),
                                icon: const Icon(Icons.hourglass_top),
                                label: const Text('Pending', style: TextStyle(color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () => _changeOrderStatus(context, 1),
                                icon: const Icon(Icons.local_shipping),
                                label: const Text('Shipped', style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () => _changeOrderStatus(context, 2),
                                icon: const Icon(Icons.cancel),
                                label: const Text('Canceled', style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
