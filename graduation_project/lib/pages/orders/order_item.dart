import 'package:flutter/material.dart';
import 'package:graduation_project/pages/product_page/product_module.dart';

class OrderItem {
  Product product;
  int quantity;
  late double price = quantity * product.price;
  OrderItem({
    required this.product,
    this.quantity = 1,
  });
}
