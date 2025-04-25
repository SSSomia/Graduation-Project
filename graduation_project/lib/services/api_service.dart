import 'dart:convert';
import 'dart:io';
import 'package:graduation_project/api_models/product_module.dart';
import 'package:graduation_project/api_models/user_model.dart';
import 'package:graduation_project/models/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://shopyapi.runasp.net/api/';

  Future<Map<String, dynamic>?> register({
    required User user,
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

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse('${baseUrl}Auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'Email': email,
        'Password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully logged in
      print("Login Successfully");
      return json.decode(response.body);
    } else {
      print("Login failed: ${response.statusCode} - ${response.body}");

      // Handle failure (returning null in this example)
      return null;
    }
  }

  Future<Map<String, dynamic>?> forgetPassword(String email) async {
    final url = Uri.parse('${baseUrl}Auth/forget-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(email),
    );

    if (response.statusCode == 200) {
      print("Email is varified");
      return json.decode(response.body);
    } else {
      print("Email not found: ${response.statusCode} - ${response.body}");

      // Handle failure (returning null in this example)
      return null;
    }
  }

  Future<Map<String, dynamic>?> resetPassword(
      String email, String token, String password) async {
    final url = Uri.parse('${baseUrl}Auth/reset-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({"Email": email, "Token": token, "NewPassword": password}),
    );

    if (response.statusCode == 200) {
      print("password updated");
      return json.decode(response.body);
    } else {
      print("password not updated: ${response.statusCode} - ${response.body}");

      // Handle failure (returning null in this example)
      return null;
    }
  }

  Future<Map<String, dynamic>?> getProfile(String token) async {
    final url = Uri.parse('${baseUrl}Account/profile');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load profile: ${response.statusCode}");
    }
  }

  // Future<Map<String, dynamic>?> updateProfile(String FirstName, String LastName,
  //     String email, String password, String profileImage) async {
  //   final url = Uri.parse('${baseUrl}Account/update');
  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({
  //       'FirstName': FirstName,
  //       'LastName': LastName,
  //       'Email': email,
  //       'Password': password,
  //       'ProfileImage': profileImage,
  //     }),
  //   );

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return json.decode(response.body);
  //   } else {
  //     print("Registration failed: ${response.statusCode} - ${response.body}");
  //     // Handle error responses
  //     return null;
  //   }
  // }

  // Function to update the profile with data
  static Future<Map<String, dynamic>> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required File? profileImage, // Optional profile image
  }) async {
    try {
      // Create a map of the profile data
      Map<String, String> requestBody = {
        'FirstName': firstName,
        'FastName': lastName,
        'Email': email,
        'Password': password,
      };

      // If there's a profile image, convert it to base64 and add it to the request body
      if (profileImage != null) {
        String base64Image = base64Encode(profileImage.readAsBytesSync());
        requestBody['ProfileImage'] = base64Image;
      }

      // Make the POST request to update the profile
      final response = await http.post(
        Uri.parse('https://shopyapi.runasp.net/api/Account/update'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody), // Send the request body as JSON
      );

      // Parse the response
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to update profile'};
      }
    } catch (error) {
      print("Error updating profile: $error");
      return {'success': false, 'message': 'An error occurred'};
    }
  }

  // static Future<List<Product>> fetchRandomProducts() async {
  //   final url =
  //       Uri.parse('https://shopyapi.runasp.net/api/Products/random-products');

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(response.body);
  //     return body.map((json) => Product.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }
  static Future<List> fetchRandomProducts(String token) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Products/random-products');
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final List<ProductModule> body = jsonDecode(response.body);
        print("true");
        // Map and cast to List<Product>
        return body.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  static Future<List<ProductModule>> fetchRandomProductss(String token) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Products/random-products');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      // Map the JSON data to a List of ProductModule objects
      return jsonData.map((item) => ProductModule.fromJson(item)).toList();
      // return json.decode(response.body);
    } else {
      throw Exception("Failed to load profile: ${response.statusCode}");
    }
  }
}
