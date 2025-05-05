import 'dart:convert';
import 'dart:io';
import 'package:graduation_project/api_models/cart_model.dart';
import 'package:graduation_project/api_models/catigory_model.dart';
import 'package:graduation_project/api_models/favorite_model.dart';
import 'package:graduation_project/api_models/order_details_model.dart';
import 'package:graduation_project/api_models/order_model.dart';
import 'package:graduation_project/api_models/pending_seller.dart';
import 'package:graduation_project/api_models/product_module.dart';
import 'package:graduation_project/api_models/store_info_model.dart';
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
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/Account/change-password'); // Adjust endpoint

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

  static Future<Cart> fetchCart(String token) async {
    final url = Uri.parse('https://shopyapi.runasp.net/api/Cart');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Cart.fromJson(data);
    } else {
      throw Exception('Cart is empty!!');
    }
  }

  static Future<bool> updateCartQuantity(
      int productId, int newQuantity, String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/Cart/update?productId=$productId&newQuantity=$newQuantity');

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Successful API call
        return true;
      } else {
        print('Failed to update cart item quantity: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error updating cart item quantity: $error');
      return false;
    }
  }

  static Future<bool> removeCartItem(int productId, String token) async {
    try {
      final response = await http.delete(
        Uri.parse(
            'https://shopyapi.runasp.net/api/Cart/remove?productId=$productId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true; // Successfully removed item
      } else {
        print('Failed to remove item: ${response.body}');
        return false; // Failed to remove item
      }
    } catch (e) {
      print('Error during API call: $e');
      return false;
    }
  }

  static Future<bool> addProductToCart(int productId, String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/Cart/add?productId=$productId');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Successful API call
        return true;
      } else {
        print('Failed to add product to cart: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error adding product to cart: $error');
      return false;
    }
  }

  static Future<List<Order>> fetchUserOrders(String token) async {
    final response = await http.get(
      Uri.parse('https://shopyapi.runasp.net/api/Order/user-orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load user orders');
    }
  }

  static Future<List<OrderDetail>> fetchOrderDetails(
      int orderId, String token) async {
    final url = 'https://shopyapi.runasp.net/api/Order/order-details/$orderId';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => OrderDetail.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load order details');
    }
  }

  static Future<Map<String, dynamic>> placeOrder({
    required int productId,
    required int quantity,
    required String fullName,
    required String address,
    required String city,
    required String government,
    required String phoneNumber,
    required String token,
  }) async {
    final url = Uri.parse('https://shopyapi.runasp.net/api/Order/buy');

    final body = {
      "productId": productId,
      "quantity": quantity,
      "fullName": fullName,
      "address": address,
      "city": city,
      "government": government,
      "phoneNumber": phoneNumber,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("object");
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return {
            'success': true,
            'message': 'Order placed successfully, but no response body.',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Order failed',
          'error': response.body.isNotEmpty
              ? json.decode(response.body)
              : 'Empty error body',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Exception occurred',
        'error': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> placeOrderFromCart({
    required String fullName,
    required String address,
    required String city,
    required String government,
    required String phoneNumber,
    required String token,
  }) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Order/buy-from-cart');

    final body = {
      "fullName": fullName,
      "address": address,
      "city": city,
      "government": government,
      "phoneNumber": phoneNumber,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print("object");
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return {
            'success': true,
            'message': 'Order placed, but no response body',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Order failed',
          'error': response.body.isNotEmpty
              ? json.decode(response.body)
              : 'Empty error body',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Exception occurred',
        'error': e.toString(),
      };
    }
  }

  static Future<String> submitStoreInfo(StoreModel store, String token) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Store/submit-store-info');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(store.toJson()),
    );

    if (response.statusCode == 200) {
      print("true");
      return 'Success';
    } else {
      throw Exception('Failed to submit store: ${response.body}');
    }
  }

  Future<List<PendingSeller>> getApprovedSellers(String token) async {
    final response = await http.get(
      Uri.parse('https://shopyapi.runasp.net/api/Admin/approved-sellers'),
      headers: {
        'Authorization': 'Bearer $token',
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => PendingSeller.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch approved sellers');
    }
  }

  Future<List<PendingSeller>> fetchPendingSellers(String token) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Admin/pending-sellers');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
        // 'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => PendingSeller.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch pending sellers');
    }
  }

  Future<Map<String, dynamic>> approveSeller(int userId, String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/Admin/approve-seller/$userId');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to approve seller: ${response.body}');
    }
  }

  Future<void> rejectSeller(int sellerId, String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/Admin/reject-seller/$sellerId');

    final response = await http.post(
      url,
      headers: {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      },
      body: {}, // Empty body
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reject seller');
    }
  }

  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('https://shopyapi.runasp.net/api/Category/categories'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<ProductModule>> fetchProductsByCategory(
      int categoryId) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/Category/by-category/$categoryId');
    final response = await http.get(url, headers: {'accept': '*/*'});

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => ProductModule.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  // static Future<Map<String, dynamic>> placeOrder({
  //   required int productId,
  //   required int quantity,
  //   required String fullName,
  //   required String address,
  //   required String city,
  //   required String government,
  //   required String phoneNumber,
  //   required String token,
  // }) async {
  //   final url = Uri.parse(
  //       'https://shopyapi.runasp.net/api/Order/buy'); // Adjust endpoint if needed

  //   final body = {
  //     "productId": productId,
  //     "quantity": quantity,
  //     "fullName": fullName,
  //     "address": address,
  //     "city": city,
  //     "government": government,
  //     "phoneNumber": phoneNumber,
  //   };

  //   // final response = await http.post(
  //   //   url,
  //   //   headers: {
  //   //     'Content-Type': 'application/json',
  //   //     'Authorization': 'Bearer $token',
  //   //   },
  //   //   body: json.encode(body),
  //   // );

  //   // if (response.statusCode == 200 || response.statusCode == 201) {
  //   //   return json.decode(response.body);
  //   // } else {
  //   //   print('${response.body}');
  //   // }
  //   // return {"message": "false"};
  //   // // } else {
  //   //   print("Order failed: ${response.body}");
  //   //   // return json.decode(response.body);
  //   // }

  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: json.encode(body),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print("object");
  //       return json.decode(response.body);
  //     } else {
  //       print('Order failed: ${response.body}');
  //       return {
  //         'success': false,
  //         'message': 'Order failed',
  //         'error': json.decode(response.body),
  //       };
  //     }
  //   } catch (e) {
  //     print('Exception during order: $e');
  //     return {
  //       'success': false,
  //       'message': 'Exception occurred',
  //       'error': e.toString(),
  //     };
  //   }
  // }
}
