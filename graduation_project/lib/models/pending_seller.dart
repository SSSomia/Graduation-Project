import 'package:intl/intl.dart';

class PendingSeller {
  final int userId;
  final String firstName;
  final String lastName;
  final String storeName;
  final String storeDescription;
  final DateTime requestDate;
  String status;

  PendingSeller(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.storeName,
      required this.storeDescription,
      required this.requestDate,
      this.status = 'pending'});
  factory PendingSeller.fromJson(Map<String, dynamic> json) {
    final formatter = DateFormat('yyyy-MM-dd hh:mm a');
    return PendingSeller(
      userId: json['userId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      storeName: json['storeName'] ?? '',
      storeDescription: json['storeDescription'] ?? '',
      requestDate: formatter.parse(json['requestDate']),
    );
  }
}
