import 'dart:io';

class Product {
  final String id;
  String productName;
  String description;
  String category;
  List<String> imageUrl;
  double price;
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
