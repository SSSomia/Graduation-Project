import 'package:flutter/material.dart';
import 'package:graduation_project/component/myDrawer.dart';
import 'package:graduation_project/pages/constant.dart';
import 'package:graduation_project/pages/home/product_card.dart';
import 'package:graduation_project/pages/home/product_module.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: .67,
          ),
          itemCount: 6, 
          itemBuilder: (context, index) {
            return ProductCard(product: Product(id: index.toString(), productName: "Product $index",
              imageUrl:
                  "https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg", // Replace with actual image URL
              price: 19.99 + index,),
              // Example price
            );
          },
        ),
      ),
    );
  }
}
