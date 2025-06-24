class LoyaltyLevelUpdate {
  final int id;
  final int level;
  final double requiredSpent;
  final double discountPercentage;

  LoyaltyLevelUpdate({
    required this.id,
    required this.level,
    required this.requiredSpent,
    required this.discountPercentage,
  });

  factory LoyaltyLevelUpdate.fromJson(Map<String, dynamic> json) {
    return LoyaltyLevelUpdate(
      id: json['id'],
      level: json['level'],
      requiredSpent: json['requiredSpent'],
      discountPercentage: json['discountPercentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level': level,
      'requiredSpent': requiredSpent,
      'discountPercentage': discountPercentage,
    };
  }
}

class LoyaltyLevelUpdateRequest {
  final List<LoyaltyLevelUpdate> levels;

  LoyaltyLevelUpdateRequest({required this.levels});

  Map<String, dynamic> toJson() {
    return {
      'levels': levels.map((e) => e.toJson()).toList(),
    };
  }
}
