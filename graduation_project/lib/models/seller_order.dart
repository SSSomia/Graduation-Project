class SellerOrder {
  final int orderId;
  final String customerName;
  final double totalPrice;
  final String address;
  final String status;
  final String date;

  SellerOrder({
    required this.orderId,
    required this.customerName,
    required this.totalPrice,
    required this.address,
    required this.status,
    required this.date,
  });

  factory SellerOrder.fromJson(Map<String, dynamic> json) {
    return SellerOrder(
      orderId: json['orderId'],
      customerName: json['customerName'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      address: json['address'],
      status: json['status'],
      date: json['date'],
    );
  }
}
