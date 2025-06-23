class DiscountSettings {
  final int id;
  final double firstOrderDiscountPercentage;

  DiscountSettings({
    required this.id,
    required this.firstOrderDiscountPercentage,
  });

  factory DiscountSettings.fromJson(Map<String, dynamic> json) {
    return DiscountSettings(
      id: json['id'],
      firstOrderDiscountPercentage: json['firstOrderDiscountPercentage'],
    );
  }
}
