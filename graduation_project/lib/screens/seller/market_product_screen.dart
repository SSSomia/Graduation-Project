// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../providers/market_provider.dart';
// import '../../widgets/product_item.dart';
// import '../product/add_product_screen.dart';

// class MarketProductScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Products',
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
//       body: Consumer<MarketProvider>(// ✅ Listen to changes
//           builder: (context, marketProvider, child) {
//         final products = marketProvider.products;
//         return ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (ctx, i) =>
//                     ProductItem(product: products[i]),
//               );
//       }),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddProductScreen()),
//           );
//         },
//       ),
//     );
//   }
// }
