// import 'package:flutter/material.dart';
// import 'package:graduation_project/models/order_item.dart';
// import 'package:graduation_project/models/product_module.dart';
// import 'package:intl/number_symbols_data.dart';

// class CartList extends ChangeNotifier {
//   Map<String, OrderItem> cartList = {};

//   double _totalPrice = 0;
//   int numberOfItems = 0;

//   double get totalPrice => _totalPrice;

//   bool isProductExist(Product product) {
//     if (cartList.containsKey(product.id)) {
//       return true;
//     }
//     return false;
//   }

//   void addItem(Product product) {
//     if (cartList.containsKey(product.id)) {
//       cartList[product.id]!.quantity++;
//     } else {
//       cartList[product.id] = OrderItem(
//         product: product,
//       );
//       numberOfItems++;
//       product.isAdded = true;
//     }
//     _totalPrice += product.price;
//     notifyListeners();
//   }

//   void removeItem(Product product) {
//     if (cartList[product.id]!.quantity == 1) {
//       _totalPrice -= product.price;
//       cartList.remove(product.id);
//       product.isAdded = false;
//     } else {
//       _totalPrice -= product.price;
//       cartList[product.id]!.quantity--;
//     }
//     notifyListeners();
//   }

//   void removeAllItem(Product product) {
//     _totalPrice -= product.price * cartList[product.id]!.quantity;
//     cartList.remove(product.id);
//     product.isAdded = false;
//     notifyListeners();
//   }

//   void clearCart() {
//     cartList.clear();
//     _totalPrice = 0;
//     numberOfItems = 0;
//     notifyListeners();
//   }
// }
