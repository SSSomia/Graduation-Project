import 'package:flutter/material.dart';

class AppBarCom extends StatefulWidget {
  const AppBarCom({super.key});

  @override
  State<AppBarCom> createState() => _AppBarComState();
}

class _AppBarComState extends State<AppBarCom> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Quraan',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: const Icon(Icons.mosque_outlined),
      backgroundColor: const Color.fromARGB(255, 80, 220, 185),
      shadowColor: const Color.fromARGB(255, 107, 255, 228),
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
    );
  }
}
