class SellerDiscount {
  final int id;
  final String user;
  final String store;
  final double discountPercentage;
  final String couponCode;
  final DateTime createdAt;
  final DateTime expiryDate;

  SellerDiscount({
    required this.id,
    required this.user,
    required this.store,
    required this.discountPercentage,
    required this.couponCode,
    required this.createdAt,
    required this.expiryDate,
  });

  factory SellerDiscount.fromJson(Map<String, dynamic> json) {
    return SellerDiscount(
      id: json['id'],
      user: json['user'],
      store: json['store'],
      discountPercentage: json['discountPercentage'],
      couponCode: json['couponCode'],
      createdAt: DateTime.parse(json['createdAt']),
      expiryDate: DateTime.parse(json['expiryDate']),
    );
  }
}
