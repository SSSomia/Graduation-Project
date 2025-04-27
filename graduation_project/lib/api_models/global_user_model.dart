// models/user_model.dart
class UserModel {
  String imageurl;
  String name;
  String UserName;
  String email;
  String createdAt;

  UserModel({
    required this.imageurl,
    required this.name,
    required this.UserName,
    required this.email,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      imageurl: json['imageUrl'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      UserName: json['userName'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
