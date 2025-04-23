import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginApi {
  final String baseUrl = "https://shopyapi.runasp.net/api/";

  // Login API call
  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url = Uri.parse('${baseUrl}Auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully logged in
      return json.decode(response.body);
    } else {
      // Handle failure (returning null in this example)
      return null;
    }
  }
}
