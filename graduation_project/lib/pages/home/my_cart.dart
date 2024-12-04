import 'package:flutter/material.dart';
import 'package:graduation_project/pages/home/cart_list.dart';
import 'package:graduation_project/pages/home/product_card.dart';
import 'package:provider/provider.dart';

class MyCart extends StatelessWidget {
  MyCart({super.key});

  CartList _cartList = CartList();
  @override
  Widget build(BuildContext context) {
    // final _cartList = Provider.of<CartList>(context);
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 2,
        ),
        itemCount: _cartList.cartList.length,
        itemBuilder: (context, index) {
          return ProductCard(
              productName: _cartList.cartList[index].productName,
              imageUrl: _cartList.cartList[index].imageUrl,
              price: _cartList.cartList[index].price);
        },
      ),
    );
  }
}
