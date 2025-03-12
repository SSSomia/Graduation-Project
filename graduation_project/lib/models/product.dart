import 'dart:io';

class Product {
  final String id;
  final String productName;
  final String description;
  final String category;
  final List<String> imageUrl;
  final double price;
  int stock;

  Product(
      {required this.id,
      required this.productName,
      required this.imageUrl,
      required this.price,
      required this.category,
      required this.stock,
      required this.description});
}
