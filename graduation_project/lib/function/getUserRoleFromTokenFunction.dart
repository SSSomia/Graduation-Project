import 'package:jwt_decoder/jwt_decoder.dart';

String? getUserRoleFromToken(String token) {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  
  // Assuming the role is stored under the 'role' key
  String? role = decodedToken["http://schemas.microsoft.com/ws/2008/06/identity/claims/role"];
  
  print("User role: $role");
  return role;
}