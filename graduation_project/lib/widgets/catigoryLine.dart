import 'package:flutter/material.dart';
import 'package:graduation_project/providers/category_provider.dart';
import 'package:graduation_project/screens/category_products.dart';
import 'package:provider/provider.dart';

class CategoryLine extends StatelessWidget {
  const CategoryLine({super.key});

  IconData _getIconForCategory(String name) {
    switch (name.toLowerCase()) {
      case 'electronics':
        return Icons.devices;
      case 'books':
        return Icons.book_outlined;
      case 'fashion':
        return Icons.shopping_bag_outlined;
      case 'home':
        return Icons.home_outlined;
      case 'art':
        return Icons.brush_outlined;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final categories = provider.categories;

        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProducts(
                        categoryId: category.id,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            const Color.fromARGB(255, 221, 230, 233),
                        child: Icon(
                          _getIconForCategory(category.name),
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category.name,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
