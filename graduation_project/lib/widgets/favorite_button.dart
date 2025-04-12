import 'package:flutter/material.dart';
import 'package:graduation_project/providers/favorite_list.dart';
import 'package:graduation_project/models/product_module.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({required this.product,super.key});
  Product product;
  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteList>(builder: (context, favoriteList, child) {
    bool isFavorite = favoriteList.isProductExist(widget.product);
      return IconButton(
          onPressed: () {
             favoriteList.addRemoveItem(widget.product);
            setState(() {
              isFavorite = isFavorite ? false : true;
            });
          },
          icon: Icon(
            isFavorite
                ? Icons.favorite
                : Icons.favorite_border, // Ternary condition for toggling
            color: isFavorite
                ? const Color.fromARGB(255, 150, 25, 16)
                : Colors.grey, // Color change based on favorite status
            size: 30.0, // Icon size
          ));
    });
  }
}
