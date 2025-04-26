class Favorite {
  final int id;
  final String name;
  final String imageUrl;

  Favorite({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['productId'],
      name: json['productName'],
      imageUrl: json['imageUrl'],
    );
  }
}