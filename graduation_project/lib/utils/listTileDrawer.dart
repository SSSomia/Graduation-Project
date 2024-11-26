import 'package:flutter/material.dart';

class ListTileDrawer extends StatelessWidget {
  late String title;
  late Icon icon;
  ListTileDrawer({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title:  Text(title),
      onTap: () {
        null;
      },
    );
  }
}
