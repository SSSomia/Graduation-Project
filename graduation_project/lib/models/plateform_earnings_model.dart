class Period {
  final String type;
  final String name;
  final String startDate;
  final String endDate;

  Period({required this.type, required this.name, required this.startDate, required this.endDate});

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      type: json['type'],
      name: json['name'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
}

class Discounts {
  final double firstOrder;
  final double loyalty;
  final double total;
  final double totalDifference;

  Discounts({required this.firstOrder, required this.loyalty, required this.total, required this.totalDifference});

  factory Discounts.fromJson(Map<String, dynamic> json) {
    return Discounts(
      firstOrder: (json['firstOrder'] ?? 0).toDouble(),
      loyalty: (json['loyalty'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      totalDifference: (json['totalDifference'] ?? 0).toDouble(),
    );
  }
}

class PlatformEarnings {
  final double gross;
  final double grossDifference;
  final double netAfterDiscounts;
  final double netAfterDiscountsDifference;

  PlatformEarnings({
    required this.gross,
    required this.grossDifference,
    required this.netAfterDiscounts,
    required this.netAfterDiscountsDifference,
  });

  factory PlatformEarnings.fromJson(Map<String, dynamic> json) {
    return PlatformEarnings(
      gross: (json['gross'] ?? 0).toDouble(),
      grossDifference: (json['grossDifference'] ?? 0).toDouble(),
      netAfterDiscounts: (json['netAfterDiscounts'] ?? 0).toDouble(),
      netAfterDiscountsDifference: (json['netAfterDiscountsDifference'] ?? 0).toDouble(),
    );
  }
}

class PlatformEarningsReport {
  final Period period;
  final int orders;
  final Discounts discounts;
  final PlatformEarnings platformEarnings;

  PlatformEarningsReport({
    required this.period,
    required this.orders,
    required this.discounts,
    required this.platformEarnings,
  });

  factory PlatformEarningsReport.fromJson(Map<String, dynamic> json) {
    return PlatformEarningsReport(
      period: Period.fromJson(json['period']),
      orders: json['orders'] ?? 0,
      discounts: Discounts.fromJson(json['discounts']),
      platformEarnings: PlatformEarnings.fromJson(json['platformEarnings']),
    );
  }
}
