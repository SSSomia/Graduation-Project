import 'package:flutter/material.dart';
import 'package:graduation_project/pages/home/product_card.dart';

class CartList extends ChangeNotifier {
  List<ProductCard> cartList = [];

  addToCartList(ProductCard product){
    cartList.add(product);
    notifyListeners();
  }
}
