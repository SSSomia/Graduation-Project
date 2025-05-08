import 'package:flutter/material.dart';
import 'package:graduation_project/models/product_module.dart';
import 'package:graduation_project/models/seller_product.dart';
import 'package:graduation_project/screens/product/seller_product_page.dart';
import 'package:graduation_project/screens/product/update_product_screen.dart';
import 'package:graduation_project/widgets/build_image.dart';

class ProductItem extends StatelessWidget {
  final ProductModule product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    //   final marketProvider = Provider.of<MarketProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SellerProductPage(productid: product.productId)),
          );
        },
        leading: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[200],
          child: ClipOval(
            child: SizedBox(
              width: 120, // 2 * radius
              height: 120,
              child: FittedBox(
                fit: BoxFit.cover,
                child: buildImage(product.imageUrls[0]),
              ),
            ),
          ),
        ),
        title: Text(product.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category: ${product.categoryName}"),
            Text("Price: \$${product.price.toStringAsFixed(2)}"),
            Text("Stock: ${product.stockQuantity} available"),
            Text("Description: ${product.description}",
                maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.mode_edit_outline_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateProductScreen(product: product),
              ),
            );
          },
        ),
      ),
    );
  }
}
