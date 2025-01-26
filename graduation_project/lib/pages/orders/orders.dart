// i will take the card design 
// make a provider for the order list
// modifiy the card of unused things


import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      "orderId": "#12345",
      "date": "Jan 20, 2025",
      "status": "Delivered",
      "total": "\$120.50",
    },
    {
      "orderId": "#12346",
      "date": "Jan 18, 2025",
      "status": "Shipped",
      "total": "\$75.00",
    },
    {
      "orderId": "#12347",
      "date": "Jan 15, 2025",
      "status": "Processing",
      "total": "\$99.99",
    },
    {
      "orderId": "#12348",
      "date": "Jan 10, 2025",
      "status": "Cancelled",
      "total": "\$40.00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order ID and Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order["orderId"],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        order["date"],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Status
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: _getStatusColor(order["status"]),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        order["status"],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(order["status"]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Total Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        order["total"],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // View details action
                        },
                        child: const Text(
                          "View Details",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          // Reorder action
                        },
                        child: const Text(
                          "Reorder",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "Shipped":
        return Colors.orange;
      case "Processing":
        return Colors.blue;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
