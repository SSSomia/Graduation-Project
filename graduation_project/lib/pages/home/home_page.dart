import 'package:flutter/material.dart';
import 'package:graduation_project/component/myDrawer.dart';
import 'package:graduation_project/pages/constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shoopy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.shopping_bag_outlined),
        backgroundColor: backgroundColor,
        shadowColor: const Color.fromARGB(255, 98, 98, 98),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
      endDrawer: MyDrawer(),
    );
  }
}
