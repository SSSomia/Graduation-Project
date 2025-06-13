class Review {
  final int rating;
  final String comment;
  final int productId;

  Review({
    required this.rating,
    required this.comment,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'productId': productId,
    };
  }
}
