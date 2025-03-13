import 'package:flutter/material.dart';

class SalesSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const SalesSummaryCard({required this.title, required this.value, required this.icon, required this.color, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 40, color: iconColor),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
