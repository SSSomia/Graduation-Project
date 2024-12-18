import 'package:flutter/material.dart';

class FavoritePress extends StatefulWidget {
  const FavoritePress({super.key});

  @override
  State<FavoritePress> createState() => _FavoritePressState();
}
class _FavoritePressState extends State<FavoritePress> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
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
  }
}
