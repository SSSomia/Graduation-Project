// import 'package:flutter/material.dart';
// import 'package:graduation_project/pages/product_page/product_module.dart';

// class OrderDetailsPage extends StatelessWidget {
//   final Map<String, Product> orderDetails;

//   const OrderDetailsPage({super.key, required this.orderDetails});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order Details"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildDetailTile("Order ID", orderDetails["orderId"] as String),
//             _buildDetailTile("Customer Name", orderDetails["customerName"] as String),
//             _buildDetailTile("Total Price", "\$${orderDetails["totalPrice"]}"),
//             _buildDetailTile("Order Status", orderDetails["status"] as String),
//             const SizedBox(height: 20),
//             const Text("Ordered Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: orderDetails.length,
//                 itemBuilder: (context, index) {
//                   final item = orderDetails["items"][index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 5),
//                     child: ListTile(
//                       leading: const Icon(Icons.shopping_bag, color: Colors.blue),
//                       title: Text(item["name"]),
//                       subtitle: Text("Quantity: ${item["quantity"]}"),
//                       trailing: Text("\$${item["price"]}"),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailTile(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           Text(value, style: const TextStyle(fontSize: 16, color: Colors.blue)),
//         ],
//       ),
//     );
//   }
// }

// void printOrders() {
//   orderList.forEach((orderId, order) {
//     print("Order ID: $orderId");
//     print("Total Price: ${order.totalPrice}");
//     print("Products in this order:");

//     for (var item in order.orderItems.values) {
//       print(
//           "- ${item.product.productName} | Quantity: ${item.quantity} | Price: ${item.price}");
//     }
//   });
// }

import 'package:flutter/material.dart';
import 'package:graduation_project/providers/order_list.dart';
import 'package:graduation_project/screens/product/productPage.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatelessWidget {
  final orderId;

  OrderDetailsPage({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<OrderList>(context).orderList[orderId];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: ListView.builder(
        itemCount: orderList?.orderItems.length,
        itemBuilder: (context, index) {
          final product = orderList?.orderItems[index];
          return Card(
              margin: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductPage(
                              product: product.product,
                            ))),
                // shape: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => ProductPage(
                //             product: item,
                //           ))),
                child: ListTile(
                  leading: Image.network(product!.product.imageUrl[0],
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text('${product.price}'),
                  subtitle: Text(
                      'Quantity: ${product.quantity}\nPrice: \$${product.price}'),
                ),
              ));
        },
      ),
    );
  }
}
