// import 'package:flutter/material.dart';
// import 'package:graduation_project/providers/login_provider.dart';
// import 'package:graduation_project/providers/order_details_provider.dart';
// import 'package:provider/provider.dart';

// class SellerOrdersDetails extends StatefulWidget {
//   final int orderId;

//   const SellerOrdersDetails({Key? key, required this.orderId}) : super(key: key);

//   @override
//   State<SellerOrdersDetails> createState() => _SellerOrdersDetailsState();
// }

// class _SellerOrdersDetailsState extends State<SellerOrdersDetails> {
//   @override
//   void initState() {
//     super.initState();

//     // Delay the load call to avoid build phase errors
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final authProvider = Provider.of<LoginProvider>(context, listen: false);

//       Provider.of<OrderDetailProvider>(context, listen: false)
//           .loadOrderDetails(widget.orderId, authProvider.token);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<OrderDetailProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order Details'),
//         backgroundColor: const Color.fromARGB(255, 58, 163, 165),
//       ),
//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : provider.error != null
//               ? Center(child: Text(provider.error!))
//               : provider.details.isEmpty
//                   ? const Center(child: Text('No order details found'))
//                   : ListView.builder(
//                       itemCount: provider.details.length,
//                       itemBuilder: (context, index) {
//                         final detail = provider.details[index];
//                         return Card(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 8),
//                           child: ListTile(
//                             leading: Image.network(
//                               detail.productImage,
//                               width: 50,
//                               height: 50,
//                               fit: BoxFit.cover,
//                             ),
//                             title: Text(detail.productName),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Quantity: ${detail.quantity}"),
//                                 Text("Unit Price: \$${detail.unitPrice}"),
//                                 Text("Subtotal: \$${detail.subtotal}"),
//                                 if (detail.discountPercentage != null)
//                                   Text(
//                                       "Discount: ${detail.discountPercentage!.toStringAsFixed(0)}%"),
//                                 if (detail.discountExpiryDate != null)
//                                   Text(
//                                     "Expires: ${detail.discountExpiryDate!.toLocal().toString().split(' ')[0]}",
//                                     style: const TextStyle(
//                                         fontSize: 12, color: Colors.red),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         );
//                       // },
//                     ),
//     );
//   }
// }
