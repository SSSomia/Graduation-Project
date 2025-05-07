
import 'package:flutter/material.dart';
import 'package:graduation_project/providers/get_products_of_category.dart';
import 'package:graduation_project/widgets/product_card.dart';
import 'package:provider/provider.dart';

class CategoryProducts extends StatefulWidget {
  CategoryProducts({super.key, required this.categoryId});
  int categoryId;
  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() =>
          Provider.of<CategoryProductProvider>(context, listen: false)
              .loadProductsByCategory(widget.categoryId));
    });
  }

  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<ProductList>(context).productMap;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Category Products"),
        ),
        body:
            Consumer<CategoryProductProvider>(builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }
          return Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.builder(
                  physics: const CustomScrollPhysics(),
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

  const CustomScrollPhysics({super.parent, this.speedFactor = 0.5});

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
