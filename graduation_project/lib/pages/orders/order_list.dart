import 'package:flutter/material.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/orders/order_module.dart';

class OrderList extends ChangeNotifier {
  Map<String, OrderModule> orderList = {};

  void newOrder(OrderModule order) {
    orderList[order.orderId] = order;
    notifyListeners();
  }
}
