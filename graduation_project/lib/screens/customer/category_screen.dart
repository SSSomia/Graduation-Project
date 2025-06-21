// import 'package:flutter/material.dart';
// import 'package:graduation_project/models/catigory_model.dart';
// import 'package:graduation_project/providers/category_provider.dart';
// import 'package:graduation_project/screens/customer/product/category_products.dart';
// import 'package:provider/provider.dart';

// class CategoriesPage extends StatelessWidget {
//   const CategoriesPage({
//     super.key,
//   });

//   IconData _getIconForCategory(String name) {
//     switch (name.toLowerCase()) {
//       case 'electronics':
//         return Icons.devices;
//       case 'books':
//         return Icons.book_outlined;
//       case 'fashion':
//         return Icons.shopping_bag_outlined;
//       case 'home':
//         return Icons.home_outlined;
//       case 'art':
//         return Icons.brush_outlined;
//       default:
//         return Icons.category;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Categories'),
//         centerTitle: true,
//       ),
//       body: Consumer<CategoryProvider>(builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final categories = provider.categories;
//         return Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: GridView.builder(
//               itemCount: categories.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: 16,
//                 childAspectRatio: 1.2,
//               ),
//               itemBuilder: (context, index) {
//                 final category = categories[index];
//                 return GestureDetector(
//                   onTap: () {
//                     // Navigate or filter based on category
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Selected: ${category.name}')),
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(31, 60, 202, 181),
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: const Color.fromARGB(255, 15, 86, 79)),
//                     ),
//                     child: Center(
//                       child: Text(
//                         category.name,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ));
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation_project/models/catigory_model.dart';
import 'package:graduation_project/providers/category_provider.dart';
import 'package:graduation_project/screens/customer/product/category_products.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  IconData _getIconForCategory(String name) {
    switch (name.toLowerCase()) {
      case 'electronics':
        return Icons.devices;
      case 'flower':
        return Icons.local_florist;
      case 'candels':
        return Icons.light_mode;
      case 'mugs':
        return Icons.coffee;
      case 'cakes':
        return Icons.cake;
      case 'accessories':
        return Icons.watch_rounded;
      case 'skin & haircare':
        return Icons.spa;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final categories = provider.categories;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryProducts(
                            categoryId: category.id,),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    color: Colors.teal.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getIconForCategory(category.name),
                            size: 40,
                            color: Colors.teal,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            category.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
