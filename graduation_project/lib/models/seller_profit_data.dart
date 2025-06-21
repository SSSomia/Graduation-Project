class ProfitData {
  final double beforeDiscount;
  final double afterPersonalDiscount;

  ProfitData({
    required this.beforeDiscount,
    required this.afterPersonalDiscount,
  });

  factory ProfitData.fromJson(Map<String, dynamic> json) {
    return ProfitData(
      beforeDiscount: (json['beforeDiscount'] ?? 0).toDouble(),
      afterPersonalDiscount: (json['afterPersonalDiscount'] ?? 0).toDouble(),
    );
  }
}

class ProfitSummaryModel {
  final ProfitData daily;
  final ProfitData monthly;
  final ProfitData yearly;

  ProfitSummaryModel({
    required this.daily,
    required this.monthly,
    required this.yearly,
  });

  factory ProfitSummaryModel.fromJson(Map<String, dynamic> json) {
    return ProfitSummaryModel(
      daily: ProfitData.fromJson(json['daily']),
      monthly: ProfitData.fromJson(json['monthly']),
      yearly: ProfitData.fromJson(json['yearly']),
    );
  }
}
