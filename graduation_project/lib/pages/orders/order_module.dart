import 'package:flutter/material.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/product_page/product_module.dart';

class OrderModule {
  final String orderId;
  final Map<String, Product> cartList;
  final DateTime dateTime;
  final double totalPrice;
  final String status;

   OrderModule({
    required this.orderId,
    required this.cartList,
    required this.dateTime,
    required this.totalPrice,
    required this.status,
  });

  String get getOrderId => orderId;
  Map get getCartList => cartList;
  DateTime get getDateTime => dateTime;
  String get getStatus => status;
  double get getTotalPrice => totalPrice;
}