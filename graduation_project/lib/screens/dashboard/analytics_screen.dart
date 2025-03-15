import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/order_pie_chart.dart';
import 'package:graduation_project/widgets/top_product_list.dart';
import 'package:provider/provider.dart';
import '../../providers/sales_provider.dart';
import '../../widgets/sales_summary_card.dart';
import '../../widgets/sales_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
final salesProvider = context.watch<SalesProvider>();  // ✅ Safe way to access provider

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Analytics',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 255, 254),
        //  shadowColor: const Color.fromARGB(255, 252, 252, 252),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(child: SalesSummaryCard(title: "Total Revenue", value: "\$${salesProvider.totalRevenue}", icon: Icons.monetization_on_outlined, color: const Color.fromARGB(255, 39, 167, 189), iconColor: const Color.fromARGB(255, 48, 119, 125),)),
                const SizedBox(width: 10),
                Expanded(child: SalesSummaryCard(title: "Total Orders", value: "${salesProvider.totalOrders}", icon: Icons.shopping_cart_outlined, color:const Color.fromARGB(255, 39, 167, 189),iconColor: const Color.fromARGB(255, 48, 119, 125),)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: SalesSummaryCard(title: "Total Profit", value: "\$${salesProvider.totalRevenue}", icon: Icons.monetization_on_outlined, color:const Color.fromARGB(255, 39, 167, 189),iconColor: const Color.fromARGB(255, 48, 119, 125),)),
                const SizedBox(width: 10),
                Expanded(child: SalesSummaryCard(title: "Total Cost", value: "\$${salesProvider.totalRevenue}", icon: Icons.monetization_on_outlined, color:const Color.fromARGB(255, 39, 167, 189),iconColor: const Color.fromARGB(255, 48, 119, 125),)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: SalesSummaryCard(title: "Completed", value: "${salesProvider.completedOrders}", icon: Icons.check_circle_outline_rounded, color:const Color.fromARGB(255, 39, 167, 189),iconColor: const Color.fromARGB(255, 48, 119, 125),)),
                const SizedBox(width: 10),
                Expanded(child: SalesSummaryCard(title: "Pending", value: "${salesProvider.pendingOrders}", icon: Icons.pending_outlined, color:const Color.fromARGB(255, 39, 167, 189),iconColor: const Color.fromARGB(255, 48, 119, 125),)),
              ],
            ),
            const SizedBox(height: 20),
            // SalesChart(),
            // const SizedBox(height: 20),
            // OrdersPieChart(),
            TopProductsList(),
          ],
        ),
      ),
    );
  }
}
