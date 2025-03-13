import 'package:flutter/material.dart';
import 'package:graduation_project/models/prodcut_mode;.dart';

class ProductProvider with ChangeNotifier {
  List<Producty> _products = [];

  List<Producty> get products => _products;

  void addProduct(Producty product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(String id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
