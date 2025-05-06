class ProductModule {
  final int productId;
  final String name;
  final double price;
  final String description;
  final int stockQuantity;
  final int categoryId;
  final String? categoryName;
  final int storeId;
  final List<String> imageUrls;

  ProductModule({
    required this.productId,
    required this.name,
    required this.price,
    required this.description,
    required this.stockQuantity,
    required this.categoryId,
    this.categoryName,
    required this.storeId,
    required this.imageUrls,
  });

  factory ProductModule.fromJson(Map<String, dynamic> json) {
    return ProductModule(
      productId: json['productId'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      stockQuantity: json['stockQuantity'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      storeId: json['storeId'],
      imageUrls: List<String>.from(json['imageUrls']),
    );
  }
}
