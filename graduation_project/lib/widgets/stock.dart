import 'package:flutter/material.dart';

class Stock extends StatelessWidget {
  String stockQuantity;
  Stock({super.key, required this.stockQuantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'In Stock: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '${stockQuantity}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}