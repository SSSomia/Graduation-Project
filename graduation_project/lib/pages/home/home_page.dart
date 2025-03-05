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
        id: "1",
        productName: "Apple iPhone 14",
        imageUrl: [
          "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
          "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
        ],
        price: 999.99,
        category: "Electronics",
        stock: 10,
        discription: "The latest iPhone with A16 Bionic chip and 48MP camera."),
    Product(
        id: "2",
        productName: "Samsung Galaxy S23",
        imageUrl: [
          "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
          "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
        ],
        price: 899.99,
        category: "Electronics",
        stock: 15,
        discription:
            "Powerful Snapdragon 8 Gen 2 processor with 120Hz AMOLED display."),
    Product(
        id: "3",
        productName: "Nike Air Max 270",
        imageUrl: [
          "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
        ],
        price: 149.99,
        category: "Footwear",
        stock: 25,
        discription: "Comfortable and stylish sneakers with a large air unit."),
    Product(
        id: "4",
        productName: "Adidas Ultraboost",
        imageUrl: [
          "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
          "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
        ],
        price: 180.00,
        category: "Footwear",
        stock: 20,
        discription: "High-performance running shoes with Boost cushioning."),
    Product(
        id: "5",
        productName: "Sony WH-1000XM5",
        imageUrl: [
          "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
          "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
        ],
        price: 399.99,
        category: "Electronics",
        stock: 8,
        discription: "Industry-leading noise-canceling wireless headphones."),
    Product(
        id: "6",
        productName: "MacBook Pro 16\"",
        imageUrl: [
          "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
          "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
        ],
        price: 2499.99,
        category: "Electronics",
        stock: 5,
        discription: "Powerful M2 Max chip with a stunning Retina display."),
    Product(
        id: "7",
        productName: "Canon EOS R6",
        imageUrl: [
          "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
          "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
        ],
        price: 2499.00,
        category: "Cameras",
        stock: 12,
        discription: "Full-frame mirrorless camera with 4K video recording."),
    Product(
        id: "8",
        productName: "Logitech MX Master 3",
        imageUrl: [
          "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
          "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
        ],
        price: 99.99,
        category: "Accessories",
        stock: 30,
        discription:
            "Advanced ergonomic wireless mouse with customizable buttons."),
    Product(
        id: "9",
        productName: "Samsung 4K Smart TV",
        imageUrl: [
          "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
          "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
        ],
        price: 699.99,
        category: "Electronics",
        stock: 7,
        discription:
            "Ultra HD 4K Smart TV with vibrant colors and Dolby Audio."),
    Product(
        id: "10",
        productName: "Bose SoundLink Revolve+",
        imageUrl: [
          "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
          "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
        ],
        price: 199.99,
        category: "Audio",
        stock: 18,
        discription: "Portable Bluetooth speaker with 360-degree sound."),
  ];

  @override
  Widget build(BuildContext context) {
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
              itemCount: 10,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
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
