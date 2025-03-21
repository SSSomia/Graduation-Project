import 'package:flutter/material.dart';
import 'package:graduation_project/pages/favorite/favorite_list.dart';
import 'package:graduation_project/pages/product_page/productPage.dart';
import 'package:provider/provider.dart';

class MyFavorites extends StatelessWidget {
  MyFavorites({super.key});

  // CartList _cartList = CartList();
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteList>(context);

    return favorite.favoriteList.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text("My Favorites"),
              backgroundColor: const Color.fromARGB(255, 255, 213, 213),
            ),
            backgroundColor: const Color.fromARGB(255, 255, 244, 244),
            body: const Center(child: Text("no items added yet")))
        : Scaffold(
            appBar: AppBar(
              title: const Text("My Favorites"),
              backgroundColor: const Color.fromARGB(255, 255, 213, 213),
            ),
            backgroundColor: const Color.fromARGB(255, 255, 244, 244),
            body: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: favorite.favoriteList.length,
                  itemBuilder: (context, index) {
                    final item = favorite.favoriteList.values.toList()[index];
                    return Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                          product: item,
                                        ))),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(item.imageUrl[0]),
                            ),
                            title: Text(item.productName),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                context
                                    .read<FavoriteList>()
                                    .addRemoveItem(item);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                )),
              ],
            ));
  }
}
