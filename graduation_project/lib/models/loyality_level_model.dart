class LoyaltyLevel {
  final String level;
  final double requiredSpent;
  final double discountPercentage;

  LoyaltyLevel({
    required this.level,
    required this.requiredSpent,
    required this.discountPercentage,
  });

  factory LoyaltyLevel.fromJson(Map<String, dynamic> json) {
    return LoyaltyLevel(
      level: json['level'],
      requiredSpent: json['requiredSpent'],
      discountPercentage: json['discountPercentage'],
    );
  }
}
