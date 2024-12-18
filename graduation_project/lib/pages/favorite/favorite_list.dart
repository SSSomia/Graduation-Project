import 'package:flutter/material.dart';
import 'package:graduation_project/pages/home/product_card.dart';
import 'package:graduation_project/pages/home/product_module.dart';

class FavoriteList extends ChangeNotifier {
  Map<String, Product> favoriteList = {};

  void addRemoveItem(Product product) {
    if (favoriteList.containsKey(product.id)) {
      favoriteList.remove(product.id);
    } else {
      favoriteList[product.id] = product;
    }
    notifyListeners();
  }
}
