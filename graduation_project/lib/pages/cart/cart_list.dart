import 'package:flutter/material.dart';
import 'package:graduation_project/pages/orders/order_module.dart';
import 'package:graduation_project/pages/product_page/product_module.dart';
import 'package:intl/number_symbols_data.dart';

class CartList extends ChangeNotifier {
 Map<String, OrderItem> cartList = {};

  double _totalPrice = 0;
  int numberOfItems = 0;

  double get totalPrice => _totalPrice;

  bool isProductExist(Product product) {
    if (cartList.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  void addItem(Product product) {
    if (cartList.containsKey(product.id)) {
      cartList[product.id]!.quantity++;
    } else {
      cartList[product.id] = OrderItem(product: product, price: product.price * product.quantity);
      numberOfItems++;
      product.isAdded = true;
    }
    _totalPrice += product.price;
    notifyListeners();
  }

  void removeItem(Product product) {
    cartList.remove(product.id);
    product.isAdded = false;
    _totalPrice -= product.price;
    notifyListeners();
  }

  void removeAllItem(Product product) {
    cartList.remove(product.id);
    product.isAdded = false;
    _totalPrice -= product.price * product.quantity;
    notifyListeners();
  }

  void clearCart() {
    cartList.clear();
    _totalPrice = 0;
    numberOfItems = 0;
    notifyListeners();
  }

  void updateQuantity(Product product, int newQuantity) {
    if (cartList.containsKey(product.id) && newQuantity > 0) {
      cartList[product.id]!.quantity = newQuantity;
    } else {
      cartList.remove(product.id);
    }
    _totalPrice -= product.price;
    notifyListeners();
  }
}
