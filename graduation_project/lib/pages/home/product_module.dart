
class Product {
  final String id;
  final String productName;
  final String imageUrl;
  final double price;
  int quantity = 1;
  bool isAdded = false;

  Product({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.price,
  });
}
