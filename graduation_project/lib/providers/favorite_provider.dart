import 'package:flutter/material.dart';
import 'package:graduation_project/models/favorite_model.dart';
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

  // Remove favorite
  Future<void> removeFavorite(String token, int id) async {
    try {
      await ApiService.removeFavorite(token, id);
      _favorites.removeWhere((fav) => fav.id == id);
      notifyListeners();
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  Future<void> addFavorite(
      String token, int id, String name, String imageUrl) async {
    try {
      final newFavorite = await ApiService.addFavorite(token, id);
      if (favorites.any((fav) => fav.id != id)) {
        _favorites.add(Favorite(id: id, name: name, imageUrl: imageUrl));
      } else {
        _favorites.removeWhere((fav) => fav.id == id);
      }
      notifyListeners();
    } catch (e) {
      print('Error adding favorite: $e');
    }
}
  }
