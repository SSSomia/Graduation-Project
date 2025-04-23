import 'dart:convert';
import 'package:graduation_project/api_models/register.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://shopyapi.runasp.net/api/';

  Future<Map<String, dynamic>?> register({ required User user,
  }) async {
    final url = Uri.parse('${baseUrl}Auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'FirstName': user.FirstName,
        'LastName': user.LastName,
        'UserName': user.UserName,
        'Email': user.Email,
        'Password': user.Password,
        'Role': user.Role,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      print("Registration failed: ${response.statusCode} - ${response.body}");
      // Handle error responses
      return null;
    }
  }
}
