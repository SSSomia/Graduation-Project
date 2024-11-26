import 'package:flutter/material.dart';
import 'package:graduation_project/pages/home/home_page.dart';
import 'package:graduation_project/pages/login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Graduation project',
      home: HomePage(),
    );
  }
}
