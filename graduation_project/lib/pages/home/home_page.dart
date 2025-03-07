import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:graduation_project/pages/category/catigoryLine.dart';
import 'package:graduation_project/pages/product_page/product_list.dart';
import 'package:graduation_project/utils/component/myDrawer.dart';
import 'package:graduation_project/pages/constant.dart';
import 'package:graduation_project/pages/product_page/product_card.dart';
import 'package:graduation_project/pages/product_page/product_module.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
  final products = Provider.of<ProductList>(context).productMap;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          CategoryLine(),
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
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products["${index+1}"]!);
              },
            ),
          ),
        ],
      ),
    );
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
