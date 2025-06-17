class LoyaltyStatusModel {
  final double totalSpent;
  final String currentLevel;
  final List<String> coupons;

  LoyaltyStatusModel({
    required this.totalSpent,
    required this.currentLevel,
    required this.coupons,
  });

  factory LoyaltyStatusModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyStatusModel(
      totalSpent: json['totalSpent']?.toDouble() ?? 0.0,
      currentLevel: json['currentLevel'] ?? 'None',
      coupons: List<String>.from(json['coupons'] ?? []),
    );
  }
}
