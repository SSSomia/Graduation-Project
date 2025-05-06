import 'package:flutter/material.dart';
import 'package:graduation_project/providers/favorite_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({
    required this.productid,
    required this.name,
    required this.image,
    super.key,
  });

  final int productid;
  final String name;
  final String image;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
      // Check if the product is already in the favorites list
      bool isFavorite =
          favoriteProvider.favorites.any((fav) => fav.id == widget.productid);

      return IconButton(
        onPressed: () async {
          final loginToken = Provider.of<LoginProvider>(context, listen: false);
          final String token = loginToken.token;

          if (isFavorite) {
            // Remove the product from the favorites list
            await favoriteProvider.removeFavorite(token, widget.productid);
          } else {
            // Add the product to the favorites list
            await favoriteProvider.addFavorite(
                token, widget.productid, widget.name, widget.image);
          }

          // Since the `FavoriteProvider` is using `ChangeNotifier`, the UI will automatically update
        },
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color:
              isFavorite ? const Color.fromARGB(255, 150, 25, 16) : Colors.grey,
          size: 30.0,
        ),
      );
    });
  }
}
