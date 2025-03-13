import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/sales_provider.dart';

class OrdersPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final salesProvider = Provider.of<SalesProvider>(context);
    final orderData = salesProvider.orderBreakdown();
    final colors = [Colors.green, Colors.orange, Colors.red];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order Breakdown", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: orderData.entries.map((entry) {
                    int index = orderData.keys.toList().indexOf(entry.key);
                    return PieChartSectionData(
                      value: entry.value,
                      title: entry.key,
                      color: colors[index],
                      radius: 50,
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
