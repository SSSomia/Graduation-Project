import 'package:flutter/material.dart';

class CategoryLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Catigory 1', 'icon': Icons.devices},
      {'name': 'Catigory 2', 'icon': Icons.shopping_bag_outlined},
      {'name': 'Catigory 3', 'icon': Icons.home_outlined},
      {'name': 'Catigory 4', 'icon': Icons.brush_outlined},
      {'name': 'Catigory 5', 'icon': Icons.book_outlined},
    ];

    return Container(
      height: 100, // Adjust height based on your design
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            //  const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color.fromARGB(255, 221, 230, 233),
                  child: Icon(category['icon'], size: 30, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 8),
                Text(category['name'],
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              ],
            ),
          );
        },
      ),
    );
  }
}
