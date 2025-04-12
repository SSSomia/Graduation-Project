import 'package:flutter/material.dart';
import 'package:graduation_project/models/product_module.dart';

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


  bool isProductExist(Product product)
  {
    if (favoriteList.containsKey(product.id))
    {
      return true;
    }
    return false;
  }

    void clearCart()
  {
    favoriteList.clear();
    notifyListeners();
  }
}


// make the favorite page by learn HOW TO USE 2 PROVIDERS AND LEARN PROVIDER IT SELF