class ProductReview {
  final String comment;
  final int userRating;
  final String userName;
  final DateTime createdAt;

  ProductReview({
    required this.comment,
    required this.userRating,
    required this.userName,
    required this.createdAt,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      comment: json['comment'],
      userRating: (json['userRating'] is int)
          ? json['userRating']
          : (json['userRating'] as num).toInt(),
      userName: json['userName'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
