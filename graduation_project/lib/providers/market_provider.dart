import 'package:flutter/material.dart';
import '../models/product.dart';

class MarketProvider extends ChangeNotifier {
  final List<Product> _products = []; // List to store products

  List<Product> get products => _products; // Getter for products

  /// **🔹 Add a new product**
  void addProduct(Product product) {
    _products.add(product);
    notifyListeners(); // ✅ Notify UI to update
  }

  /// **🔹 Update an existing product**
  void updateProduct(Product updatedProduct) {
    int index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners(); // ✅ Notify UI to update
    }
  }

  /// **🔹 Delete a product**
  void deleteProduct(String productId) {
    _products.removeWhere((p) => p.id == productId);
    notifyListeners(); // ✅ Notify UI to update
  }
}
