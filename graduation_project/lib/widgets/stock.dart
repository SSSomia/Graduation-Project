import 'package:flutter/material.dart';
import 'package:graduation_project/api_providers/cart_provider.dart';
import 'package:graduation_project/api_providers/login_provider.dart';
import 'package:graduation_project/api_providers/product_provider.dart';
import 'package:graduation_project/product_list/product_list.dart';
import 'package:provider/provider.dart';

class Stock extends StatelessWidget {
  String stockQuantity;
  Stock({super.key, required this.stockQuantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'In Stock: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '${stockQuantity}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:graduation_project/api_providers/login_provider.dart';
// import 'package:graduation_project/api_providers/product_provider.dart';
// import 'package:provider/provider.dart';

// class Stock extends StatelessWidget {
//   final int productId;
//   Stock({super.key, required this.productId});

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<LoginProvider>(context, listen: false);
//     final productProvider = Provider.of<ProductProvider>(context);

//     return FutureBuilder(
//       future: productProvider.fetchProductById(authProvider.token, productId),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }

//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }

//         if (!snapshot.hasData || productProvider.product == null) {
//           return const Text('No product data found.');
//         }

//         return Row(
//           children: [
//             const Text(
//               'In Stock: ',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '${productProvider.product!.stockQuantity.toString()}',
//               style:
//                   const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
