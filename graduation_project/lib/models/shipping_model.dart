class Shipping {
  final int id;
  final double cost;
  final DateTime updatedAt;

  Shipping({
    required this.id,
    required this.cost,
    required this.updatedAt,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      id: json['id'],
      cost: json['cost'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
