import 'package:flutter/material.dart';
import 'package:graduation_project/models/ai_search_model.dart';
import 'package:graduation_project/services/api_service.dart';

class AiSearchProvider with ChangeNotifier {
  List<SearchResult> _results = [];
  bool _isLoading = false;
  String? _error;

  List<SearchResult> get results => _results;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> search(String query, int top) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _results = await ApiService.searchProducts(query, top);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearResults() {
    _results = [];
    _error = null;
    notifyListeners();
  }
}
