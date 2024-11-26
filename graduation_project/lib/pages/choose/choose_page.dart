import 'package:flutter/material.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  String? _selectedOption = "USER";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          RadioListTile<String>(
            title: const Text("USER"),
            value: "USER",
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text("SELLER"),
            value: "SELLER",
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
