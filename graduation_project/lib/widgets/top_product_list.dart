import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providerNotUse/analytics_provider.dart';

class TopProductsList extends StatelessWidget {
  const TopProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final analyticsProvider = Provider.of<AnalyticsProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Top-Selling Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Column(
              children: analyticsProvider.topProducts.map((product) {
                return ListTile(
                  title: Text(product["name"]),
                  trailing: Text("${product["sales"]} sales"),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
