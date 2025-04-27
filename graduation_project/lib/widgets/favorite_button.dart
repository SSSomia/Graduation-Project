// import 'package:flutter/material.dart';
// import 'package:graduation_project/api_providers/favorite_provider.dart';
// import 'package:graduation_project/api_providers/login_provider.dart';
// import 'package:graduation_project/providers/favorite_list.dart';
// import 'package:graduation_project/models/product_module.dart';
// import 'package:provider/provider.dart';

// class FavoriteButton extends StatefulWidget {
//   FavoriteButton(
//       {required this.productid,
//       required this.name,
//       required this.image,
//       super.key});
//   int productid;
//   String name, image;
//   @override
//   State<FavoriteButton> createState() => _FavoriteButtonState();
// }

// class _FavoriteButtonState extends State<FavoriteButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<FavoriteProvider>(
//         builder: (context, favoriteButton, child) {
//       bool favorite =
//           favoriteButton.favorites.any((fav) => fav.id == widget.productid);
//       return IconButton(
//           onPressed: () async {
//             final loginToken =
//                 Provider.of<LoginProvider>(context, listen: false);
//             final String token = loginToken.token;

//             await favoriteButton.addFavorite(
//                 token, widget.productid, widget.name, widget.image);

//             setState(() {
//               favorite = favoriteButton.favorites
//                   .any((fav) => fav.id == widget.productid);
//             }); // After updating the favorites
//           },
//           icon: Icon(
//             favorite
//                 ? Icons.favorite
//                 : Icons.favorite_border, // Ternary condition for toggling
//             color: favorite
//                 ? const Color.fromARGB(255, 150, 25, 16)
//                 : Colors.grey, // Color change based on favorite status
//             size: 30.0, // Icon size
//           ));
//     });
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:graduation_project/api_providers/favorite_provider.dart';
// // import 'package:graduation_project/api_providers/login_provider.dart';
// // import 'package:provider/provider.dart';

// // class FavoriteButton extends StatefulWidget {
// //   FavoriteButton({
// //     required this.productid,
// //     required this.name,
// //     required this.image,
// //     super.key,
// //   });

// //   int productid;
// //   String name, image;

// //   @override
// //   State<FavoriteButton> createState() => _FavoriteButtonState();
// // }

// // class _FavoriteButtonState extends State<FavoriteButton> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<FavoriteProvider>(
// //         builder: (context, favoriteProvider, child) {
// //       bool isFavorite =
// //           favoriteProvider.favorites.any((fav) => fav.id == widget.productid);

// //       return IconButton(
// //         onPressed: () async {
// //           final loginToken = Provider.of<LoginProvider>(context, listen: false);
// //           final String token = loginToken.token;

// //           if (isFavorite) {
// //             // If already favorite, remove it
// //             await favoriteProvider.removeFavorite(token, widget.productid);
// //           } else {
// //             // If not favorite, add it
// //             await favoriteProvider.addFavorite(
// //                 token, widget.productid, widget.name, widget.image);
// //           }

// //           setState(() {}); // Force rebuild after adding/removing
// //         },
// //         icon: Icon(
// //           isFavorite ? Icons.favorite : Icons.favorite_border,
// //           color:
// //               isFavorite ? const Color.fromARGB(255, 150, 25, 16) : Colors.grey,
// //           size: 30.0,
// //         ),
// //       );
// //     });
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:graduation_project/api_providers/favorite_provider.dart';
// // import 'package:graduation_project/api_providers/login_provider.dart';
// // import 'package:provider/provider.dart';

// // class FavoriteButton extends StatelessWidget {
// //   FavoriteButton({required this.productid, super.key});
// //   final int productid;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<FavoriteProvider>(
// //       builder: (context, favoriteProvider, child) {
// //         bool isFavorite = favoriteProvider.favorites.contains(productid);

// //         return IconButton(
// //           onPressed: () async {
// //             final loginToken =
// //                 Provider.of<LoginProvider>(context, listen: false);
// //             final String token = loginToken.token;

// //             if (isFavorite) {
// //               await favoriteProvider.removeFavorite(token, productid);
// //             } else {
// //               await favoriteProvider.addFavorite(token, productid);
// //             }
// //           },
// //           icon: Icon(
// //             favoriteProvider.favorites.contains(productid)
// //                 ? Icons.favorite
// //                 : Icons.favorite_border,
// //             color: favoriteProvider.favorites.contains(productid)
// //                 ? const Color.fromARGB(255, 150, 25, 16)
// //                 : Colors.grey,
// //             size: 30.0,
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:graduation_project/api_providers/favorite_provider.dart';
import 'package:graduation_project/api_providers/login_provider.dart';
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
