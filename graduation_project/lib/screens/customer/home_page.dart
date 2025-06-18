import 'package:flutter/material.dart';
import 'package:graduation_project/providers/category_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/products_provider.dart';
import 'package:graduation_project/widgets/banner.dart';
import 'package:graduation_project/widgets/catigoryLine.dart';
import 'package:graduation_project/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
      Future.microtask(() =>
          Provider.of<CategoryProvider>(context, listen: false)
              .loadCategories());
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
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: searchController,
          //     decoration: InputDecoration(
          //       hintText: "Search...",
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(),
          //     ),
          //     onChanged: (value) {
          //       setState(() {
          //         query = value;
          //       });
          //     },
          //   ),
          // ),
          const SizedBox(
            height: 15,
          ),
          // PromoBannerList(),
          // const CategoryLine(),
          Expanded(
            child: GridView.builder(
              physics: const CustomScrollPhysics(),
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
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

  const CustomScrollPhysics({super.parent, this.speedFactor = 1.0});

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
