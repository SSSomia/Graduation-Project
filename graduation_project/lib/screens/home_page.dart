import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:graduation_project/api_providers/login_provider.dart';
import 'package:graduation_project/api_providers/products_provider.dart';
import 'package:graduation_project/not%20used/category/catigoryLine.dart';
import 'package:graduation_project/product_list/product_list.dart';
import 'package:graduation_project/widgets/myDrawer.dart';
import 'package:graduation_project/not%20used/constant.dart';
import 'package:graduation_project/widgets/product_card.dart';
import 'package:graduation_project/models/product_module.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchRandomProducts(authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<ProductList>(context).productMap;
    return Scaffold(
        body: Consumer<ProductsProvider>(builder: (context, provider, _) {
      if (provider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (provider.error != null) {
        return Center(child: Text('Error: ${provider.error}'));
      } else if (provider.products.isEmpty) {
        return const Center(child: Text('No products found.'));
      }
      return Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          //CategoryLine(),
          Expanded(
            child: GridView.builder(
              physics: CustomScrollPhysics(),
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .67,
              ),
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                final product = provider.products[index];
                return ProductCard(product: product);
              },
            ),
          ),
        ],
      );
    }));
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  final double speedFactor;

  CustomScrollPhysics({ScrollPhysics? parent, this.speedFactor = 0.5})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
        parent: buildParent(ancestor), speedFactor: speedFactor);
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    return offset * speedFactor; // Adjust the scroll speed
  }
}

// import 'package:flutter/material.dart';
// import 'package:graduation_project/api_providers/login_provider.dart';
// import 'package:graduation_project/api_providers/products_provider.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final authProvider = Provider.of<LoginProvider>(context, listen: false);
//    Provider.of<ProductsProvider>(context, listen: false)
//         .fetchRandomProducts(authProvider.token);
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<ProductsProvider>(
//         builder: (context, provider, _) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (provider.error != null) {
//             return Center(child: Text('Error: ${provider.error}'));
//           } else if (provider.products.isEmpty) {
//             return const Center(child: Text('No products found.'));
//           }

//           return ListView.builder(
//             itemCount: provider.products.length,
//             itemBuilder: (context, index) {
//               final product = provider.products[index];

//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//                 child: ListTile(
//                   leading: product.imageUrls.isNotEmpty
//                       ? ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.network(
//                             product.imageUrls[0],
//                             width: 60,
//                             height: 60,
//                             fit: BoxFit.cover,
//                           ),
//                         )
//                       : const Icon(Icons.image_not_supported),
//                   title: Text(product.name),
//                   subtitle: Text(
//                     product.description,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   trailing: Text(
//                     "\$${product.price}",
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
