// import 'package:flutter/material.dart';
// import 'package:graduation_project/providers/category_provider.dart';
// import 'package:graduation_project/providers/login_provider.dart';
// import 'package:graduation_project/providers/products_provider.dart';
// import 'package:graduation_project/widgets/banner.dart';
// import 'package:graduation_project/widgets/loyatity_widget.dart';
// import 'package:graduation_project/widgets/product_card.dart';
// import 'package:provider/provider.dart';

// class ScrollMainPage extends StatefulWidget {
//   const ScrollMainPage({super.key});

//   @override
//   State<ScrollMainPage> createState() => ScrollMainPageState();
// }

// class ScrollMainPageState extends State<ScrollMainPage> {
//   late ScrollController _scrollController;
//   bool _showBanners = true;
//   final TextEditingController _searchController = TextEditingController();
// @override
// void initState() {
//   super.initState();

//   _scrollController.addListener(() {
//     final offset = _scrollController.offset;

//     if (offset <= 10 && !_showBanners) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) setState(() => _showBanners = true);
//       });
//     } else if (offset > 10 && _showBanners) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) setState(() => _showBanners = false);
//       });
//     }
//   });

//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     final authProvider = Provider.of<LoginProvider>(context, listen: false);
//     Provider.of<ProductsProvider>(context, listen: false)
//         .fetchRandomProducts(authProvider.token);
//     Provider.of<CategoryProvider>(context, listen: false).loadCategories();
//   });
// }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final token = Provider.of<LoginProvider>(context).token;

//     return Scaffold(
//       body: Consumer<ProductsProvider>(
//         builder: (context, provider, _) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (provider.error != null) {
//             return Center(child: Text('Error: ${provider.error}'));
//           } else if (provider.products.isEmpty) {
//             return const Center(child: Text('No products found.'));
//           }

//           return CustomScrollView(
//             controller: _scrollController,
//             slivers: [
//               SliverToBoxAdapter(
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 15),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 8,
//                               offset: Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: TextField(
//                           controller: _searchController,
//                           decoration: const InputDecoration(
//                             hintText: "Search...",
//                             prefixIcon: Icon(Icons.search, color: Colors.grey),
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 14),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     if (_showBanners) LoyaltyBanner(token: token),
//                     const SizedBox(height: 15),
//                   ],
//                 ),
//               ),
//               SliverPadding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 sliver: SliverGrid(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 30,
//                     childAspectRatio: .67,
//                   ),
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       final product = provider.products[index];
//                       return ProductCard(product: product);
//                     },
//                     childCount: provider.products.length,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation_project/providers/loyality_provider.dart';
import 'package:graduation_project/widgets/loyatity_widget.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/providers/category_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/products_provider.dart';
import 'package:graduation_project/widgets/product_card.dart';

class ScrollMainPage extends StatefulWidget {
  const ScrollMainPage({super.key});

  @override
  State<ScrollMainPage> createState() => ScrollMainPageState();
}

class ScrollMainPageState extends State<ScrollMainPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showBanners = true;
  final TextEditingController _searchController = TextEditingController();

  bool isWaiting = false; // Add this as a class variable

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final offset = _scrollController.offset;

      if (!isWaiting) {
        isWaiting = true;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;

          final shouldShow = offset <= 10;

          if (_showBanners != shouldShow) {
            setState(() {
              _showBanners = shouldShow;
            });
          }

          isWaiting = false;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchRandomProducts(authProvider.token);
      Provider.of<CategoryProvider>(context, listen: false).loadCategories();
      final loyaltyProvider =
          Provider.of<LoyaltyProvider>(context, listen: false);
      loyaltyProvider.loadLoyaltyStatus(authProvider.token);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<LoginProvider>(context).token;

    return Scaffold(
      body: Consumer<ProductsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          } else if (provider.products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    if (_showBanners) LoyaltyBanner(token: token),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 30,
                    childAspectRatio: .67,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = provider.products[index];
                      return ProductCard(product: product);
                    },
                    childCount: provider.products.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
