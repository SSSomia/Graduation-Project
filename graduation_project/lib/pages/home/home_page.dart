import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:graduation_project/pages/category/catigoryLine.dart';
import 'package:graduation_project/utils/component/myDrawer.dart';
import 'package:graduation_project/pages/constant.dart';
import 'package:graduation_project/pages/product_page/product_card.dart';
import 'package:graduation_project/pages/product_page/product_module.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<Product> products = [
    Product(
      id: '1',
      productName: 'Wireless Mouse',
      imageUrl:
          'https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg',
      price: 25.99,
    ),
    Product(
      id: '2',
      productName: 'Mechanical Keyboard',
      imageUrl:
          'https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg',
      price: 49.99,
    ),
    Product(
      id: '3',
      productName: 'Bluetooth Speaker',
      imageUrl:
          'https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg',
      price: 39.99,
    ),
    Product(
      id: '4',
      productName: 'Smartwatch',
      imageUrl:
          'https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg',
      price: 79.99,
    ),
    Product(
      id: '5',
      productName: 'Laptop Stand',
      imageUrl:
          'https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg',
      price: 19.99,
    ),
    Product(
      id: '6',
      productName: 'Portable SSD',
      imageUrl:
          'https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg',
      price: 99.99,
    ),
    Product(
      id: '7',
      productName: 'Gaming Headset',
      imageUrl:
          'https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg',
      price: 59.99,
    ),
    Product(
      id: '8',
      productName: 'Webcam',
      imageUrl:
          'https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg',
      price: 29.99,
    ),
    Product(
      id: '9',
      productName: 'USB-C Hub',
      imageUrl:
          'https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg',
      price: 34.99,
    ),
    Product(
      id: '10',
      productName: 'Ergonomic Chair',
      imageUrl:
          'https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg',
      price: 199.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          CategoryLine(),
          Expanded(
            child: Container(
              child: GridView.builder(
                physics: CustomScrollPhysics(), 
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: .67,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
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
