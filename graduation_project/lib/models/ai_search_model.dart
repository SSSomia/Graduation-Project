class SearchResult {
  final String category;
  final List<String> imageUrls;
  final String name;
  final double price;

  SearchResult({
    required this.category,
    required this.imageUrls,
    required this.name,
    required this.price,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      category: json['category'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
    );
  }
}
