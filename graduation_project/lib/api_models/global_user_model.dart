// models/user_model.dart
class UserModel {
  final String imageurl;
  final String name;
  final String email;
  final String createdAt;

  UserModel({
    required this.imageurl,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      imageurl: json['imageUrl'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
