import 'package:flutter/material.dart';
import '../models/market.dart';
import '../models/product.dart';

class MarketProvider with ChangeNotifier {
  Market _market = Market(id: "1", name: "My Market", products: []);

  Market get market => _market;

  void addProduct(Product product) {
    _market.products.add(product);
    notifyListeners();
  }

  void removeProduct(String productId) {
    _market.products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}
