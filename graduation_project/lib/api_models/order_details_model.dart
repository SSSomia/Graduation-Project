class OrderDetail {
  final int productId;
  final String productName;
  final String productImage;
  final int quantity;
  final double unitPrice;
  final double subtotal;
  final double? discountPercentage;
  final DateTime? discountExpiryDate;

  OrderDetail({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    this.discountPercentage,
    this.discountExpiryDate,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
      discountPercentage: json['discountPercentage'] != null
          ? (json['discountPercentage'] as num).toDouble()
          : null,
      discountExpiryDate: json['discountExpiryDate'] != null
          ? DateTime.parse(json['discountExpiryDate'])
          : null,
    );
  }
}
