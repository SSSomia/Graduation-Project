import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/search_model.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier {
  List<SearchedProduct> _results = [];
  bool _isLoading = false;

  List<SearchedProduct> get results => _results;
  bool get isLoading => _isLoading;

  Future<void> searchProducts(String query) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://shopyapi.runasp.net/api/Products/search?query=$query');

    try {
      final response = await http.get(url, headers: {
        'accept': '*/*',
      });

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _results = data.map((item) => SearchedProduct.fromJson(item)).toList();
      } else {
        _results = [];
      }
    } catch (e) {
      _results = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    _results = [];
    notifyListeners();
  }
}
