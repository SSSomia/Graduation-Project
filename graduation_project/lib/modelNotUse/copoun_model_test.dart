class Coupon {
  final String id;
  final String title;
  final double discount;      // e.g. 15 = 15 %
  final DateTime startDate;   // NEW
  final DateTime expiryDate;

  Coupon({
    required this.id,
    required this.title,
    required this.discount,
    required this.startDate,
    required this.expiryDate,
  });
}
