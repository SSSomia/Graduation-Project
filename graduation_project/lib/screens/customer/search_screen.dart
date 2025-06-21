import 'package:flutter/material.dart';
import 'package:graduation_project/providers/search_provider.dart';
import 'package:graduation_project/screens/customer/product/productPage.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  void _search(String query) {
    Provider.of<SearchProvider>(context, listen: false).searchProducts(query);
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _search(_controller.text);
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onSubmitted: _search,
              ),
            ),
          ),
          if (searchProvider.isLoading)
            const CircularProgressIndicator()
          else if (searchProvider.results.isEmpty)
            const Text("No products found.")
          else
            Expanded(
              child: ListView.builder(
                itemCount: searchProvider.results.length,
                itemBuilder: (context, index) {
                  final product = searchProvider.results[index];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(productid: product.productId),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                product.image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    product.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "\$${product.price}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 185, 28, 28),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                  // return Card(
                  //   margin:
                  //       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  //   child: ListTile(
                  //     leading: Image.network(
                  //       product.image,
                  //       width: 60,
                  //       height: 60,
                  //       fit: BoxFit.cover,
                  //     ),
                  //     title: Text(product.name),
                  //     subtitle: Text(product.description),
                  //     trailing: Text("\$${product.price}"),
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ProductPage(
                  //                 productid: product.productId)),
                  //       );
                  //     },
                  //   ),
                  // );
                },
              ),
            ),
        ],
      ),
    );
  }
}
