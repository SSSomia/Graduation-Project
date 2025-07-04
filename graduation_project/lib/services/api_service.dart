import 'dart:convert';
import 'dart:io';
import 'package:graduation_project/models/admin_message_details.dart';
import 'package:graduation_project/models/admin_message_model.dart';
import 'package:graduation_project/models/admin_order_model_details.dart';
import 'package:graduation_project/models/ai_search_model.dart';
import 'package:graduation_project/models/all_seller_discount.dart';
import 'package:graduation_project/models/buy_from_cart_response.dart';
import 'package:graduation_project/models/buyer.dart';
import 'package:graduation_project/models/cart_model.dart';
import 'package:graduation_project/models/catigory_model.dart';
import 'package:graduation_project/models/contact_model.dart';
import 'package:graduation_project/models/dicount_seller_model.dart';
import 'package:graduation_project/models/favorite_model.dart';
import 'package:graduation_project/models/frist_order_discount.dart';
import 'package:graduation_project/models/loyality_level_model.dart';
import 'package:graduation_project/models/loyality_level_model_update.dart';
import 'package:graduation_project/models/loyality_status.dart';
import 'package:graduation_project/models/message_model.dart';
import 'package:graduation_project/models/notification_model.dart';
import 'package:graduation_project/models/order_details_model.dart';
import 'package:graduation_project/models/order_fee_model.dart';
import 'package:graduation_project/models/order_model.dart';
import 'package:graduation_project/models/pending_seller.dart';
import 'package:graduation_project/models/plateform_earnings_model.dart';
import 'package:graduation_project/models/product_module.dart';
import 'package:graduation_project/models/product_review.dart';
import 'package:graduation_project/models/seller_order.dart';
import 'package:graduation_project/models/seller_order_product.dart';
import 'package:graduation_project/models/seller_product.dart';
import 'package:graduation_project/models/seller_profit_data.dart';
import 'package:graduation_project/models/shipping_model.dart';
import 'package:graduation_project/models/store_info_model.dart';
import 'package:graduation_project/models/top_selling_prodcuts.dart';
import 'package:graduation_project/models/track_order.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/models/reviews_model.dart';
import 'package:http_parser/http_parser.dart';

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
      return {'message': response.body};
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
      return json.decode(response.body);
    } else {
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
      return json.decode(response.body);
    } else {
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
      return json.decode(response.body);
    } else {
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
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (error) {
      //  return null;
    }
    return null;
  }

//// changes made here*********************************
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
        // Map and cast to List<Product>
        return body
            .map((json) => ProductModule.fromJson(json as Map<String, dynamic>))
            .toList();
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

      return jsonData.map((item) => ProductModule.fromJson(item)).toList();
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
        return false;
      }
    } catch (e) {
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
        return false;
      }
    } catch (error) {
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
        return false; // Failed to remove item
      }
    } catch (e) {
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
        return false;
      }
    } catch (error) {
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

  static Future<Map<String, dynamic>> fetchOrderDetails(
      int orderId, String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/Order/order-details/$orderId');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load order details: ${response.statusCode}');
    }
  }

  static Future<void> confirmDelivery(int orderId, String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/Order/confirm-delivery?orderId=$orderId'); // Replace if different

    final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to confirm delivery");
    }
  }

  // static Future<List<OrderDetail>> fetchOrderDetails(
  //     int orderId, String token) async {
  //   final url = 'https://shopyapi.runasp.net/api/Order/order-details/$orderId';
  //   final response = await http.get(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = jsonDecode(response.body);
  //     return data.map((item) => OrderDetail.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load order details');
  //   }
  // }

  // static Future<List<OrderDetail>> fetchOrderDetails(int orderId, String token) async {
  //   final url = Uri.parse(
  //       'https://shopyapi.runasp.net/api/Order/order-details/$orderId');

  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'accept': '*/*',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       final List<dynamic> products = data['products']; // <- updated key
  //       return products.map((e) => OrderDetail.fromJson(e)).toList();
  //     } else {
  //       throw Exception('Failed to load order details: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching order details: $e');
  //     rethrow;
  //   }
  // }

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

  static Future<BuyFromCartResponse?> placeOrderFromCart({
    required String token,
    required String fullName,
    required String address,
    required String city,
    required String government,
    required String phoneNumber,
  }) async {
    final url =
        Uri.parse("https://shopyapi.runasp.net/api/Order/buy-from-cart");

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
      body: jsonEncode({
        "fullName": fullName,
        "address": address,
        "city": city,
        "government": government,
        "phoneNumber": phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      return BuyFromCartResponse.fromJson(jsonDecode(response.body));
    } else {
      print("Order API Error: ${response.body}");
      return null;
    }
  }

  // static Future<Map<String, dynamic>> placeOrderFromCart({
  //   required String fullName,
  //   required String address,
  //   required String city,
  //   required String government,
  //   required String phoneNumber,
  //   required String token,
  // }) async {
  //   final url =
  //       Uri.parse('https://shopyapi.runasp.net/api/Order/buy-from-cart');

  //   final body = {
  //     "fullName": fullName,
  //     "address": address,
  //     "city": city,
  //     "government": government,
  //     "phoneNumber": phoneNumber,
  //   };

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
  //       // print("object");
  //       if (response.body.isNotEmpty) {
  //         return json.decode(response.body);
  //       } else {
  //         return {
  //           'success': true,
  //           'message': 'Order placed, but no response body',
  //         };
  //       }
  //     } else {
  //       return {
  //         'success': false,
  //         'message': 'Order failed',
  //         'error': response.body.isNotEmpty
  //             ? json.decode(response.body)
  //             : 'Empty error body',
  //       };
  //     }
  //   } catch (e) {
  //     return {
  //       'success': false,
  //       'message': 'Exception occurred',
  //       'error': e.toString(),
  //     };
  //   }
  // }

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

  Future<int> getUnreadNotificationCount(String token) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Notification/unread/count');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return int.tryParse(response.body.trim()) ?? 0;
    } else {
      throw Exception('Failed to fetch notification count');
    }
  }

  static Future<List<AppNotification>> fetchNotifications(String token) async {
    final response = await http.get(
      Uri.parse('https://shopyapi.runasp.net/api/Notification'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => AppNotification.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> markAsRead(String token, int id) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Notification/$id/read');

    final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to mark notification as read');
    }
  }

  Future<Map<String, dynamic>> addProduct({
    required String token,
    required SellerProduct product,
    required List<File> images,
  }) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://shopyapi.runasp.net/api/Products/add-product'));

    // Headers
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['accept'] = '*/*';

    // Fields
    request.fields.addAll(product.toFormFields());

    // Images
    for (var image in images) {
      request.files
          .add(await http.MultipartFile.fromPath('Images', image.path));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to add product: ${response.statusCode} ${response.body}');
    }
  }

  Future<List<ProductModule>> fetchMyProducts(String token) async {
    var uri = Uri.parse('https://shopyapi.runasp.net/api/Products/my-products');

    var response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> productList = json.decode(response.body);
      print("true");
      return productList
          .map((product) => ProductModule.fromJson(product))
          .toList();
    } else {
      print('not updated');
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  }

  Future<String?> updateProductSimple({
    required int productId,
    required String token,
    required String name,
    required String description,
    required double price,
    required int stockQuantity,
    required int categoryId,
    // required File imageFile,
    required List<File> images,
  }) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Products/$productId');

    final request = http.MultipartRequest('PUT', url);

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['accept'] = '*/*';

    request.fields['Name'] = name;
    request.fields['Description'] = description;
    request.fields['Price'] = price.toString();
    request.fields['StockQuantity'] = stockQuantity.toString();
    request.fields['CategoryId'] = categoryId.toString();

    // final multipartFile = await http.MultipartFile.fromPath(
    //   'Images',
    //   images.path,
    //   contentType: MediaType('image', 'png'),
    // );

    // for (var image in images) {
    //   request.files
    //       .add(await http.MultipartFile.fromPath('Images', image.path));
    // }
    // request.files.add(multipartFile);

    if (images.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'Images',
          images.first.path,
          contentType: MediaType('image', 'png'),
        ),
      );
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print(' $responseBody');

      return 'Product updated successfully.';
    } else {
      print('Error response: $responseBody');
      final errorBody = await response.stream.bytesToString();
      return 'Error ${response.statusCode}: $errorBody';
    }
  }

  static Future<String?> deleteProduct(int productId, String token) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Products/$productId');

    final response = await http.delete(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Product deleted successfully!');
      return 'Product deleted successfully!';
    } else {
      print(
          'Failed to delete product: ${response.statusCode} ${response.body}');
      return 'Error ${response.statusCode}: ${response.body}';
    }
  }

  Future<List<TopSellingProduct>> fetchTopSellingProducts(String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/ProductStatistics/top-selling-products');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("true");
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => TopSellingProduct.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top-selling products');
    }
  }

  Future<String?> addReview(Review review, String token) async {
    final url = Uri.parse('https://shopyapi.runasp.net/api/Review/add-review');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(review.toJson()),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body['message'];
      } else {
        return 'Failed to add review: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<List<ProductReview>> getReviews(int productId, String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/Review/all-reviews?productId=$productId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': '*/*',
      },
    );
    print("Status: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ProductReview.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      // No reviews exist for this product
      return []; // Return an empty list instead of throwing
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<List<Buyer>> fetchMyBuyers(String token) async {
    final url = Uri.parse('https://shopyapi.runasp.net/api/Store/my-buyers');
    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Buyer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch buyers');
    }
  }

  Future<List<SellerOrder>> fetchOrdersByStatus({
    required int statusCode,
    required String token,
  }) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/SellerOrders/orders/status/$statusCode?sortOldToNew=true');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => SellerOrder.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<List<OrderProduct>> fetchOrderProducts({
    required int orderId,
    required String token,
  }) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/SellerOrders/orders/$orderId/products');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List products = decoded['products'];
      return products.map((e) => OrderProduct.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load order products');
    }
  }

  Future<bool> updateSellerProductOrderStatus({
    required int orderId,
    required int newStatus,
    required String token,
  }) async {
    final url = Uri.parse(
      'https://shopyapi.runasp.net/api/SellerOrders/orders/$orderId/update-my-products?newStatus=$newStatus',
    );

    final response = await http.put(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update order status');
    }
  }

  Future<bool> sendDiscount({
    required Discount discount,
    required String token,
  }) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/SellerDiscount/send-discount');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "accept": "*/*"
      },
      body: jsonEncode(
        discount.toJson(), // ✅ Wrap in "dto"
      ),
    );
    print(
        "Sending coupon: code=${discount.couponCode}, expiry=${discount.expiryDate}, ${discount.userId}");

    if (response.statusCode == 200) {
      print("object");
      return true;
    } else {
      print("Send discount failed: ${response.body}");
      return false;
    }
  }

  Future<List<SellerDiscount>> fetchSellerDiscounts(String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/SellerDiscount/my-discounts');
    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((json) => SellerDiscount.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load seller discounts');
    }
  }

  static Future<bool> deleteSellerDiscount(String token, int discountId) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/SellerDiscount/delete/$discountId');

    try {
      final response = await http.delete(
        url,
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Discount deleted successfully.');
        return true;
      } else {
        print('Failed to delete discount. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception while deleting discount: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> applyPromoCode({
    required String promoCode,
    required String token,
  }) async {
    final url = Uri.parse(
      'https://shopyapi.runasp.net/api/Order/apply-promocode?promoCode=$promoCode',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("false");
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<TrackingModel> fetchTracking(int orderId, String token) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Order/track-order/$orderId');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return TrackingModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch tracking data: ${response.statusCode}');
    }
  }

  static Future<LoyaltyStatusModel?> fetchLoyaltyStatus(String token) async {
    final url =
        Uri.parse('https://shopyapi.runasp.net/api/Order/api/loyalty/status');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        return LoyaltyStatusModel.fromJson(json.decode(response.body));
      } else {
        print('Failed to load loyalty status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in LoyaltyService: $e');
    }

    return null;
  }

  static Future<String?> sendContactMessage(
      String token, String subject, String message) async {
    try {
      final response = await http.post(
        Uri.parse('https://shopyapi.runasp.net/api/Contact/send'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'accept': '*/*',
        },
        body: jsonEncode({
          'subject': subject,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body['message'] ?? 'Message sent successfully';
      } else {
        return 'Failed to send message. Status: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error sending message: $e';
    }
  }

  static Future<ContactMessageDetail?> getMessageDetails(
      String token, int id) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://shopyapi.runasp.net/api/Contact/message-details/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ContactMessageDetail.fromJson(data);
      } else {
        throw Exception('Failed to load message details');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<MessageModel>> fetchMyMessages(String token) async {
    final response = await http.get(
      Uri.parse('https://shopyapi.runasp.net/api/Contact/my-messages'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((item) => MessageModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch messages');
    }
  }

  static Future<Map<String, List<AdminMessage>>> fetchAdminMessages(
      String token) async {
    final response = await http.get(
      Uri.parse('https://shopyapi.runasp.net/api/Contact/admin/messages'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final unread = (data['unreadMessages'] as List)
          .map((msg) => AdminMessage.fromJson(msg))
          .toList();
      final read = (data['readMessages'] as List)
          .map((msg) => AdminMessage.fromJson(msg))
          .toList();
      return {'unread': unread, 'read': read};
    } else {
      throw Exception('Failed to fetch admin messages');
    }
  }

  static Future<AdminMessageDetail> fetchAdminMessageDetail(
      String token, int id) async {
    final response = await http.get(
      Uri.parse('https://shopyapi.runasp.net/api/Contact/admin/messages/$id'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return AdminMessageDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load message detail');
    }
  }

  static Future<void> sendAdminReply(
      String token, int messageId, String reply) async {
    final response = await http.post(
      Uri.parse('https://shopyapi.runasp.net/api/Contact/admin/reply'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'messageId': messageId,
        'adminReply': reply,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send reply');
    }
  }

  static Future<ProfitSummaryModel?> fetchProfitSummary(String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/SellerOrders/report/profit-summary');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProfitSummaryModel.fromJson(jsonData);
      } else {
        print("Failed to fetch data: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error in API: $e");
    }

    return null;
  }

  static Future<List<AdminOrderDetailsModel>> fetchAdminOrders(
      String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/AdminDashBorde/orders/overview/details');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("true");
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((orderJson) => AdminOrderDetailsModel.fromJson(orderJson))
          .toList();
    } else {
      print("false");
      throw Exception('Failed to fetch admin order details');
    }
  }

  static Future<OrderFeesModel> fetchOrderFees(
      int orderId, String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/AdminDashBorde/order-fees/$orderId');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return OrderFeesModel.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load order fees');
    }
  }

  static Future<List<LoyaltyLevel>> fetchLoyaltyLevels(String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/AdminDiscount/admin/loyalty-levels');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((json) => LoyaltyLevel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch loyalty levels');
    }
  }

  static Future<Shipping> getShipping(String token) async {
    final url = Uri.parse('https://shopyapi.runasp.net/api/Shipping');

    final response = await http.get(url, headers: {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Shipping.fromJson(data);
    } else {
      throw Exception('Failed to fetch shipping info');
    }
  }

  static Future<Shipping> updateShipping(String token, double newCost) async {
    final url = Uri.parse('https://shopyapi.runasp.net/api/Shipping');

    final response = await http.put(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: newCost.toString(), // API accepts raw number as body
    );

    if (response.statusCode == 200) {
      return Shipping.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update shipping');
    }
  }

  static Future<DiscountSettings> getSettings(String token) async {
    final url = Uri.parse('https://shopyapi.runasp.net/api/discount-settings');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return DiscountSettings.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load discount settings');
    }
  }

  static Future<String> updateSettings(
      String token, double newPercentage) async {
    final url = Uri.parse('https://shopyapi.runasp.net/api/discount-settings');

    final response = await http.put(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "id": 1,
        "firstOrderDiscountPercentage": newPercentage,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      throw Exception('Failed to update discount setting');
    }
  }

  static Future<List<PlatformEarningsReport>> fetchReports(String token) async {
    final url = Uri.parse(
        'https://shopyapi.runasp.net/api/discount-settings/admin/platform-earnings-report');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'accept': '*/*',
    });

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => PlatformEarningsReport.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load platform earnings report');
    }
  }

//   static Future<bool> updateLoyaltyLevels(
//       String token, LoyaltyLevelUpdate level) async {
//     final response = await http.post(
//       Uri.parse(
//           'https://shopyapi.runasp.net/api/AdminDiscount/admin/loyalty-levels'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//         'accept': '*/*',
//       },
//       body: jsonEncode(level.toJson()),
//     );
// if (response.statusCode == 200)
// {
//   print("true");

// }
// else
// {
//   print(response.body);
// }
//     return response.statusCode == 200;
//   }
  // static Future<bool> updateLoyaltyLevels(
  //     String token, LoyaltyLevelUpdateRequest request) async {
  //   print("Sending JSON: ${jsonEncode(request.toJson())}");

  //   final response = await http.post(
  //     Uri.parse(
  //         'https://shopyapi.runasp.net/api/AdminDiscount/admin/loyalty-levels'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //       'accept': '*/*',
  //     },
  //     body: jsonEncode(request.toJson()),
  //   );

  //   if (response.statusCode == 200) {
  //     print("Update successful");
  //   } else {
  //     print("Update failed: ${response.body}");
  //   }

  //   return response.statusCode == 200;
  // }

  static Future<bool> updateLoyaltyLevels(
      String token, LoyaltyLevelUpdateRequest request) async {
    final body = jsonEncode(request.levels.map((e) => e.toJson()).toList());
    print("Sending JSON: $body"); // For debug

    final response = await http.post(
      Uri.parse(
          'https://shopyapi.runasp.net/api/AdminDiscount/admin/loyalty-levels'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'accept': '*/*',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print("Update successful");
    } else {
      print("Update failed: ${response.body}");
    }

    return response.statusCode == 200;
  }

  
  static Future<List<SearchResult>> searchProducts(String query, int top) async {
    final url = Uri.parse('https://shielded-shore-89078-1e229438f36b.herokuapp.com/search');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'word': query, 'top': top}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      return results.map((e) => SearchResult.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch search results');
    }
  }
}
