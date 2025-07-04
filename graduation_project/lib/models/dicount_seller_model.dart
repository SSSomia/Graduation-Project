import 'package:intl/intl.dart';

class Discount {
  final int userId;
  final String couponCode;
  final int discountPercentage;
  final DateTime expiryDate;

  Discount({
    required this.userId,
    required this.couponCode,
    required this.discountPercentage,
    required this.expiryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "couponCode": couponCode,
      "discountPercentage": discountPercentage,
      "expiryDate":  DateFormat('yyyy-MM-dd').format(expiryDate),
    };
  }
}
