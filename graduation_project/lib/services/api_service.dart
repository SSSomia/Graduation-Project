import 'dart:convert';
import 'dart:io';
import 'package:graduation_project/api_models/favorite_model.dart';
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
      print("object");
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load profile: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>?> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String userName,
    File? profileImage,
    required String token,
  }) async {
    try {
      final uri = Uri.parse('https://shopyapi.runasp.net/api/Account/update');
      var request = http.MultipartRequest('PUT', uri);

      // Add fields
      request.fields['FirstName'] = firstName;
      request.fields['LastName'] = lastName;
      request.fields['Email'] = email;
      request.fields['UserName'] = userName;

      // Add profile image if exists
      if (profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'ProfileImage',
          profileImage.path,
        ));
      }

      // Add headers (especially the Authorization)
      request.headers['Authorization'] = 'Bearer $token';

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("true");
        return json.decode(response.body);
      } else {
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        return json.decode(response.body);
      }
    } catch (error) {
      print("Error updating profile: $error");
      //  return null;
    }
  }

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

  static Future<ProductModule> fetchProductById(
      String token, int productId) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Products/$productId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return ProductModule.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  // Fetch favorites
  static Future<List<Favorite>> fetchFavorites(String token) async {
    final response = await http.get(
      Uri.parse('https://shopyapi.runasp.net/api/Favourite/my'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((item) => Favorite.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  // Remove favorite
  static Future<void> removeFavorite(String token, int id) async {
    final response = await http.delete(
      Uri.parse(
          'https://shopyapi.runasp.net/api/Favourite/remove?productId=$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete favorite');
    }
  }

  // Add favorite
  static Future<String> addFavorite(String token, int id) async {
    final response = await http.post(
      Uri.parse(
          'https://shopyapi.runasp.net/api/Favourite/toggle?productId=$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to add favorite');
    }
  }

  static Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String token, // Token passed from Provider
  }) async {
    final url = Uri.parse('https://shopyapi.runasp.net/api/Account/change-password'); // Adjust endpoint

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'currentPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to change password: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
