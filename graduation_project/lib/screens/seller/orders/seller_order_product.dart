import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_order_product_provider.dart';
import 'package:graduation_project/providers/seller_order_provider.dart';
import 'package:graduation_project/screens/seller/product/seller_product_page.dart';
import 'package:provider/provider.dart';

class OrderProductsPage extends StatefulWidget {
  final int orderId;
  final String status;

  const OrderProductsPage(
      {Key? key, required this.orderId, required this.status})
      : super(key: key);

  @override
  State<OrderProductsPage> createState() => _OrderProductsPageState();
}

class _OrderProductsPageState extends State<OrderProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<OrderProductsProvider>(context, listen: false)
          .loadProducts(authProvider.token, widget.orderId);
    });
  }

  void _changeOrderStatus(BuildContext context, int newStatus) async {
    if (isProcessing) return; // Prevent multiple presses
    setState(() {
      isProcessing = true;
    });
    final authProvider = Provider.of<LoginProvider>(context, listen: false);
    final provider = Provider.of<OrderProductsProvider>(context, listen: false);

    await provider
        .updateOrderStatus(widget.orderId, newStatus, authProvider.token)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order status updated')),
      );
      Navigator.pop(context, true); // Refresh previous page
    });
  }

  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order #${widget.orderId} Products',
        ),
        backgroundColor: const Color.fromARGB(255, 255, 243, 243),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.products.isEmpty
              ? const Center(child: Text('No products in this order.'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: provider.products.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final product = provider.products[index];
                          return InkWell(
                              onTap: () {
                                // Navigate to product details or show dialog, etc.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SellerProductPage(
                                      productid: product.productId,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 3,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 183, 26, 26),
                                    child: Text(
                                      product.productId.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  title: Text(product.productName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  subtitle: Text(
                                      'Qty: ${product.quantity.toString()}'),
                                  trailing: Text(
                                    '${product.unitPrice.toStringAsFixed(2)} EGP',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 191, 39, 39)),
                                  ),
                                ),
                              ));
                        },
                      ),
                    ),
                    (isProcessing ||
                            widget.status == 'Pending')
                        ? Divider()
                        : SizedBox.shrink(),
                    (isProcessing ||
                            widget.status == 'Pending')
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Change Order Status',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // spacing: 12,
                                  // runSpacing: 8,
                                  children: [
                                    // ElevatedButton.icon(
                                    //   onPressed: () => _changeOrderStatus(context, 0),
                                    //   icon: const Icon(Icons.hourglass_top),
                                    //   label: const Text(
                                    //     'Pending',
                                    //     style: TextStyle(color: Colors.white),
                                    //   ),
                                    //   style: ElevatedButton.styleFrom(
                                    //     backgroundColor: Colors.orange,
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 150,
                                      child: ElevatedButton.icon(
                                        onPressed: isProcessing ||
                                                widget.status == 'shipped' ||
                                                widget.status == 'canceled' ||
                                                widget.status == 'delivered'
                                            ? null
                                            : () =>
                                                _changeOrderStatus(context, 1),
                                        icon: const Icon(
                                            Icons.local_shipping_outlined,
                                            color: Colors.white),
                                        label: const Text('Shipped',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 48, 182, 175),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: ElevatedButton.icon(
                                        onPressed: isProcessing ||
                                                widget.status == 'shipped' ||
                                                widget.status == 'canceled' ||
                                                widget.status == 'delivered'
                                            ? null
                                            : () =>
                                                _changeOrderStatus(context, 2),
                                        icon: const Icon(Icons.cancel_outlined,
                                            color: Colors.white),
                                        label: const Text('Canceled',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
    );
  }
}
