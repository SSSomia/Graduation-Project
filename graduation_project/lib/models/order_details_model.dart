class OrderDetail {
  final int productId;
  final String productName;
  final String productImage;
  final int quantity;
  final double originalPrice;
  final double finalPrice;
  final double subtotal;

  OrderDetail({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.originalPrice,
    required this.finalPrice,
    required this.subtotal,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      productId: json['productId'],
      productName: json['productName'],
      productImage: (json['images'] as List).isNotEmpty
          ? json['images'][0]
          : '', // Fallback to empty string if no image
      quantity: json['quantity'],
      originalPrice: (json['originalPrice'] as num).toDouble(),
      finalPrice: (json['finalPrice'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
    );
  }
}
