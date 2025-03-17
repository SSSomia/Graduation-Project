import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  List<dynamic> _items = [];

  List<dynamic> get items => _items;

  // Future<void> fetchData() async {
  //   final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     _items = jsonDecode(response.body);
  //     notifyListeners(); // Important!
  //   } else {
  //     print('Failed to load data');
  //   }
  // }

  Future<void> fetchData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    try {
      final response = await http.get(url);
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        _items = jsonDecode(response.body);
        print("Data Fetched: $items");
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  //  Future<List<dynamic>> fetchData() async {
  //   final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     notifyListeners();
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }
  // Future<List<dynamic>> fetchData() async {
  //   final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //     notifyListeners();
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }
//   Future<void> fetchData() async {
//   final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
//   try {
//     final response = await http.get(url);
//     print("Response Status Code: ${response.statusCode}");
//     print("Response Body: ${response.body}");

//     if (response.statusCode == 200) {
//       List data = jsonDecode(response.body);
//       print("Data Fetched: $data");
//     } else {
//       print('Failed to load data');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }

  Future<void> sendData(String title, String body) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'body': body,
        'userId': 1,
      }),
    );

    if (response.statusCode == 201) {
      print('Data sent successfully: ${response.body}');
    } else {
      print('Failed to send data');
    }
  }

  Future<void> updateData(int id) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$id');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': 'Updated Title',
        'body': 'Updated content',
        'userId': 1,
      }),
    );

    if (response.statusCode == 200) {
      print('Data updated successfully');
    } else {
      print('Failed to update data');
    }
  }
}
