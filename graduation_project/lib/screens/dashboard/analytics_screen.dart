import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/order_pie_chart.dart';
import 'package:provider/provider.dart';
import '../../providers/sales_provider.dart';
import '../../widgets/sales_summary_card.dart';
import '../../widgets/sales_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
final salesProvider = context.watch<SalesProvider>();  // ✅ Safe way to access provider

    return Scaffold(
      appBar: AppBar(title: const Text("Sales & Analytics")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(child: SalesSummaryCard(title: "Total Revenue", value: "\$${salesProvider.totalRevenue}", icon: Icons.attach_money, color: Colors.green)),
                const SizedBox(width: 10),
                Expanded(child: SalesSummaryCard(title: "Total Orders", value: "${salesProvider.totalOrders}", icon: Icons.shopping_cart, color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: SalesSummaryCard(title: "Completed", value: "${salesProvider.completedOrders}", icon: Icons.check_circle, color: Colors.teal)),
                const SizedBox(width: 10),
                Expanded(child: SalesSummaryCard(title: "Pending", value: "${salesProvider.pendingOrders}", icon: Icons.pending, color: Colors.orange)),
              ],
            ),
            const SizedBox(height: 20),
            SalesChart(),
            const SizedBox(height: 20),
            OrdersPieChart(),
          ],
        ),
      ),
    );
  }
}
