class OrderFeesModel {
  final int orderId;
  final double shippingCost;
  final double platformFee;
  final double totalWithFees;
  final String orderDate;

  OrderFeesModel({
    required this.orderId,
    required this.shippingCost,
    required this.platformFee,
    required this.totalWithFees,
    required this.orderDate,
  });

  factory OrderFeesModel.fromJson(Map<String, dynamic> json) {
    return OrderFeesModel(
      orderId: json['orderId'],
      shippingCost: (json['shippingCost'] ?? 0).toDouble(),
      platformFee: (json['platformFee'] ?? 0).toDouble(),
      totalWithFees: (json['totalWithFees'] ?? 0).toDouble(),
      orderDate: json['orderDate'] ?? '',
    );
  }
}
