class Buyer {
  final int userId;
  final String userName;
  final int ordersCount;

  Buyer({
    required this.userId,
    required this.userName,
    required this.ordersCount,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) {
    return Buyer(
      userId: json['userId'],
      userName: json['userName'],
      ordersCount: json['ordersCount'],
    );
  }
}
