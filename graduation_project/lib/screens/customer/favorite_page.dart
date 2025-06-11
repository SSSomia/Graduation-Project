import 'package:flutter/material.dart';
import 'package:graduation_project/providers/favorite_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/screens/customer/product/productPage.dart';
import 'package:provider/provider.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({super.key});

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    final loginToken = Provider.of<LoginProvider>(context, listen: false);

    final String token =
        loginToken.token; // 🔥 Replace this with your real user token

    try {
      await favoriteProvider.fetchFavorites(token);
    } catch (e) {
      print('Error loading favorites: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites"),
        backgroundColor: const Color.fromARGB(255, 255, 213, 213),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : favorite.favorites.isEmpty
              ? const Center(child: Text("No items added yet"))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: favorite.favorites.length,
                        itemBuilder: (context, index) {
                          final item = favorite.favorites[index];
                          return Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: ListTile(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductPage(productid: item.id),
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(item.imageUrl)),
                                  title: Text(item.name),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      final loginToken =
                                          Provider.of<LoginProvider>(context,
                                              listen: false);

                                      final String token = loginToken
                                          .token; // 🔥 Replace this with your real user token

                                      context
                                          .read<FavoriteProvider>()
                                          .removeFavorite(token, item.id);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
