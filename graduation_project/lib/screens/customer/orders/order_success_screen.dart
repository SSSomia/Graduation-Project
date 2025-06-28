// import 'package:flutter/material.dart';
// import 'package:graduation_project/models/buy_from_cart_response.dart';

// class OrderSuccessScreen extends StatelessWidget {
//   final BuyFromCartResponse ?response;

//   const OrderSuccessScreen({super.key, required this.response});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order Summary"),
//         backgroundColor: Colors.green,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "🎉 Order Placed Successfully!",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
//             ),
//             const SizedBox(height: 16),

//             Text("Message: ${response!.message}"),
//             const SizedBox(height: 8),

//             _buildAmountRow("Total Original Price:", response!.totalOriginalPrice),
//             _buildAmountRow("Discounted Amount:", response!.discountedAmount),
//             _buildAmountRow("First Order Discount:", response!.firstOrderDiscountAmount),
//             _buildAmountRow("Final Price:", response!.totalFinalPrice),
//             _buildAmountRow("Shipping Fee:", response!.shippingFee),
//             _buildAmountRow("Platform Fee:", response!.platformFee),
//             const Divider(),
//             _buildAmountRow("Total With Shipping:", response!.totalWithShipping, isBold: true),

//             const SizedBox(height: 16),
//             const Text(
//               "Discounted Products:",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             const SizedBox(height: 8),

//             Expanded(
//               child: ListView.builder(
//                 itemCount: response!.discountedProducts.length,
//                 itemBuilder: (context, index) {
//                   final product = response!.discountedProducts[index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     child: ListTile(
//                       title: Text(product.productName),
//                       subtitle: Text(
//                           "Qty: ${product.quantity} | Original: \$${product.originalPrice} | Final: \$${product.finalPrice}"),
//                       trailing: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text("Before: \$${product.subtotalBeforeDiscount}"),
//                           Text("After: \$${product.subtotalAfterDiscount}"),
//                         ],
//                       ),
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

//   Widget _buildAmountRow(String label, double amount, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
//           Text("\$${amount.toStringAsFixed(2)}",
//               style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:graduation_project/models/buy_from_cart_response.dart';

class OrderSuccessScreen extends StatelessWidget {
  final BuyFromCartResponse? response;

  const OrderSuccessScreen({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
        backgroundColor: const Color.fromARGB(255, 255, 241, 241),
      ),
      body: response == null
          ? const Center(child: Text("No order data available."))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Icon(Icons.check_circle_outline,
                            size: 60, color:Color.fromARGB(255, 255, 167, 167)),
                        SizedBox(height: 8),
                        Text(
                          "Order Placed Successfully!",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 185, 28, 28),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoCard("Message", response!.message),
                  const SizedBox(height: 12),
                  _buildSectionTitle("Pricing Summary"),
                  _buildAmountRow(
                      "Original Price", response!.totalOriginalPrice),
                  _buildAmountRow("Discount", response!.discountedAmount),
                  _buildAmountRow("First Order Discount",
                      response!.firstOrderDiscountAmount),
                  _buildAmountRow("Final Price", response!.totalFinalPrice),
                  _buildAmountRow("Shipping Fee", response!.shippingFee),
                  const Divider(height: 24),
                  _buildAmountRow(
                      "Total With Shipping", response!.totalWithShipping,
                      isBold: true),
                  const SizedBox(height: 20),
                  _buildSectionTitle("Discounted Products"),
                  const SizedBox(height: 8),
                  ...response!.discountedProducts.map((product) => Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(product.productName),
                          subtitle: Text(
                            "Qty: ${product.quantity} | Original: \$${product.originalPrice.toStringAsFixed(2)} | Final: \$${product.finalPrice.toStringAsFixed(2)}",
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  "Before: \$${product.subtotalBeforeDiscount.toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 12)),
                              Text(
                                  "After: \$${product.subtotalAfterDiscount.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.of(context)
                          .popUntil((route) => route.isFirst),
                      icon: const Icon(Icons.home,color: Colors.white,),
                      label: const Text("Back to Home",style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 185, 28, 28),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
    );
  }

  Widget _buildAmountRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: 15,
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: 15,
              color: isBold ? Colors.green[700] : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
