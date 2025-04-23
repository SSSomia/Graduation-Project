class User {
  final String FirstName;
  final String LastName;
  final String UserName;
  final String Email;
  final String Password;
  final int Role;

  User({required this.FirstName, required this.LastName, required this.UserName, required this.Email,required this.Password, required this.Role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      FirstName: json['FirstName'],
      LastName: json['LastName'],
      UserName: json['UserName'],
      Email: json['Email'],
      Password: json['Password'],
      Role: json['Role'],
    );
  }
}
