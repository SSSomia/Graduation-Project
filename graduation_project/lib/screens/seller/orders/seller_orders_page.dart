import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_order_provider.dart';
import 'package:graduation_project/screens/seller/orders/seller_order_product.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SellerOrdersPage extends StatefulWidget {
  const SellerOrdersPage({super.key});

  @override
  State<SellerOrdersPage> createState() => _SellerOrdersPageState();
}

class _SellerOrdersPageState extends State<SellerOrdersPage> {
  final Map<String, int> statusMap = {
    'All Orders': 0,
    'Pending': 1,
    'Shipped': 2,
    'Delivered': 3,
    'Canceled': 4,
  };

  String selectedStatus = 'All Orders';

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() {
    final authProvider = Provider.of<LoginProvider>(context, listen: false);
    final provider = Provider.of<SellerOrdersProvider>(context, listen: false);
    provider.loadOrders(authProvider.token, statusMap[selectedStatus]!);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellerOrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Orders'),
        backgroundColor: const Color.fromARGB(255, 255, 238, 238),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: InputDecoration(
                labelText: 'Filter by Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: statusMap.keys.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (String? newStatus) {
                if (newStatus != null) {
                  setState(() {
                    selectedStatus = newStatus;
                  });
                  _loadOrders();
                }
              },
            ),
          ),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.orders.isEmpty
                    ? const Center(child: Text('No orders found.'))
                    : ListView.builder(
                        itemCount: provider.orders.length,
                        itemBuilder: (context, index) {
                          final order = provider.orders[index];
                          final formattedDate = DateFormat.yMMMd()
                              .add_jm()
                              .format(DateTime.parse(order.date));

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 3,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              onTap: () async {
                                final shouldRefresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderProductsPage(
                                        orderId: order.orderId,
                                        status: order.status),
                                  ),
                                );
                                if (shouldRefresh == true) {
                                  final loginProvider =
                                      Provider.of<LoginProvider>(context,
                                          listen: false);
                                  final orderProvider =
                                      Provider.of<SellerOrdersProvider>(context,
                                          listen: false);
                                  await orderProvider.loadOrders(
                                    loginProvider.token,
                                    statusMap[selectedStatus]!,
                                  );
                                }
                              },
                              title: Text(
                                order.customerName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Address: ${order.address}'),
                                    Text('Date: $formattedDate'),
                                  ],
                                ),
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${order.totalPrice.toStringAsFixed(2)} EGP',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: _statusColor(order.status),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      order.status,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'shipped':
        return const Color.fromARGB(255, 226, 82, 82).withOpacity(0.1);
      case 'delivered':
        return const Color.fromARGB(255, 243, 176, 176).withOpacity(0.1);
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
