class SellerProduct {
  final String name;
  final String description;
  final double price;
  final int stockQuantity;
  final int categoryId;
  final List<String>? imagePaths; // Optional local paths

  SellerProduct({
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.categoryId,
    this.imagePaths,
  });

  Map<String, String> toFormFields() {
    return {
      'Name': name,
      'Description': description,
      'Price': price.toString(),
      'StockQuantity': stockQuantity.toString(),
      'CategoryId': categoryId.toString(),
    };
  }
}
