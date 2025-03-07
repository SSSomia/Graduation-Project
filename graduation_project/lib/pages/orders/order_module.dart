import 'package:flutter/material.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/orders/order_item.dart';
import 'package:graduation_project/pages/product_page/product_module.dart';

class OrderModule {
  final String orderId;
  final Map<String, OrderItem> orderItems;
  final DateTime dateTime;
  final double totalPrice;
  final String status;
  final int numberOfItems;

  OrderModule(
      {required this.orderId,
      required this.orderItems,
      required this.dateTime,
      required this.totalPrice,
      required this.status,
      required this.numberOfItems});
}
