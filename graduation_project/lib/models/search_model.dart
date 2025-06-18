class SearchedProduct {
  final int productId;
  final String name;
  final String description;
  final double price;
  final String image;

  SearchedProduct({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory SearchedProduct.fromJson(Map<String, dynamic> json) {
    return SearchedProduct(
      productId: json['productId'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}
