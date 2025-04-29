class Order {
  final int orderId;
  final DateTime orderDate;
  final double totalPrice;

  Order({
    required this.orderId,
    required this.orderDate,
    required this.totalPrice,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      orderDate: DateTime.parse(json['orderDate']),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}
