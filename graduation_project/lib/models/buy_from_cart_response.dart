class DiscountedProduct {
  final String productName;
  final int quantity;
  final double originalPrice;
  final double finalPrice;
  final double subtotalBeforeDiscount;
  final double subtotalAfterDiscount;
  final double discountPercentage;

  DiscountedProduct({
    required this.productName,
    required this.quantity,
    required this.originalPrice,
    required this.finalPrice,
    required this.subtotalBeforeDiscount,
    required this.subtotalAfterDiscount,
    required this.discountPercentage,
  });

  factory DiscountedProduct.fromJson(Map<String, dynamic> json) {
    return DiscountedProduct(
      productName: json['productName'],
      quantity: json['quantity'],
      originalPrice: json['originalPrice'].toDouble(),
      finalPrice: json['finalPrice'].toDouble(),
      subtotalBeforeDiscount: json['subtotalBeforeDiscount'].toDouble(),
      subtotalAfterDiscount: json['subtotalAfterDiscount'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
    );
  }
}

class BuyFromCartResponse {
  final String message;
  final double totalOriginalPrice;
  final double discountedAmount;
  final double firstOrderDiscountAmount;
  final double totalFinalPrice;
  final double shippingFee;
  final double platformFee;
  final double totalWithShipping;
  final List<DiscountedProduct> discountedProducts;

  BuyFromCartResponse({
    required this.message,
    required this.totalOriginalPrice,
    required this.discountedAmount,
    required this.firstOrderDiscountAmount,
    required this.totalFinalPrice,
    required this.shippingFee,
    required this.platformFee,
    required this.totalWithShipping,
    required this.discountedProducts,
  });

  factory BuyFromCartResponse.fromJson(Map<String, dynamic> json) {
    var list = (json['discountedProducts'] as List)
        .map((e) => DiscountedProduct.fromJson(e))
        .toList();
    return BuyFromCartResponse(
      message: json['message'],
      totalOriginalPrice: json['totalOriginalPrice'].toDouble(),
      discountedAmount: json['discountedAmount'].toDouble(),
      firstOrderDiscountAmount: json['firstOrderDiscountAmount'].toDouble(),
      totalFinalPrice: json['totalFinalPrice'].toDouble(),
      shippingFee: json['shippingFee'].toDouble(),
      platformFee: json['platformFee'].toDouble(),
      totalWithShipping: json['totalWithShipping'].toDouble(),
      discountedProducts: list,
    );
  }
}
