import 'package:flutter/material.dart';
import 'package:graduation_project/pages/cart/cart_list.dart';
import 'package:graduation_project/pages/product_page/productPage.dart';
import 'package:graduation_project/pages/product_page/product_module.dart';
import 'package:provider/provider.dart';

class ListTileItem extends StatelessWidget {
  final Product item; // Define the type of item as CartItem (or appropriate type)

  const ListTileItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartList>(
      builder: (context, cartItem, child) {
        return ListTile(onTap: () =>  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(product: item,))),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.imageUrl),
          ),
          title: Text(item.productName),
          subtitle: Text("Price: \$${item.price.toStringAsFixed(2)}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (item.quantity > 1) {
                    cartItem.updateQuantity(item, item.quantity - 1);
                  } else {
                    cartItem.removeItem(item);
                  }
                },
              ),
              Text("${item.quantity}"),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  cartItem.addItem(item);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
