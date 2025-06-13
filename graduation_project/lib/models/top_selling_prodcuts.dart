class TopSellingProduct {
  final String productName;
  final int unitsSold;
  final double revenue;
  final String imageUrl;

  TopSellingProduct({
    required this.productName,
    required this.unitsSold,
    required this.revenue,
    required this.imageUrl,
  });

  factory TopSellingProduct.fromJson(Map<String, dynamic> json) {
    return TopSellingProduct(
      productName: json['productName'],
      unitsSold: json['unitsSold'],
      revenue: json['revenue'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}
