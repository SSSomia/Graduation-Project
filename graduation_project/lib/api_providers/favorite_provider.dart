import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/favorite_model.dart';
import 'package:graduation_project/services/api_service.dart';

class FavoriteProvider with ChangeNotifier {
  List<Favorite> _favorites = [];

  List<Favorite> get favorites => _favorites;

  // Fetch favorites (with token)
  Future<void> fetchFavorites(String token) async {
    try {
      _favorites = await ApiService.fetchFavorites(token);
      notifyListeners();
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }
}
