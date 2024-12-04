import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graduation_project/component/myDrawer.dart';
import 'package:graduation_project/pages/constant.dart';
import 'package:graduation_project/pages/home/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shoopy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.shopping_bag_outlined),
        backgroundColor: backgroundColor,
        shadowColor: const Color.fromARGB(255, 98, 98, 98),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
      endDrawer: const MyDrawer(),
      body: Container(
        height: 300,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2/2,
          ),
          itemCount: 6, 
          itemBuilder: (context, index) {
            return ProductCard(
              productName: "Product $index",
              imageUrl:
                  "https://i.pinimg.com/originals/35/94/79/3594793ee69d85ab8e82e780537fa83e.jpg", // Replace with actual image URL
              price: 19.99 + index, // Example price
            );
          },
        ),
      ),
    );
  }
}
