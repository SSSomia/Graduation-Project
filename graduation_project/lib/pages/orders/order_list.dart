import 'package:flutter/material.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/orders/order_module.dart';

class OrderList extends ChangeNotifier {
  Map<String, OrderModule> orderList = {};

  void newOrder(OrderModule order) {
    orderList[order.orderId] = order;
  //  printOrders();
    notifyListeners();
  }

  // void printOrders() {
  //   orderList.forEach((orderId, order) {
  //     print("Order ID: $orderId");
  //     print("Total Price: ${order.totalPrice}");
  //     print("Products in this order:");

  //     for (var item in order.orderItems.values) {
  //       print(
  //           "- ${item.product.productName} | Quantity: ${item.quantity} | Price: ${item.price}");
  //     }
  //   });
  // }
}
