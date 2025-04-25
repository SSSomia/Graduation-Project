import 'package:flutter/material.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:graduation_project/screens/edit_profile_data.dart';
import 'package:graduation_project/screens/home_page.dart';
import 'package:graduation_project/widgets/chang_password.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color.fromARGB(255, 247, 255, 255),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          sectionHeader("Account"),
          buildCardTile(Icons.person, "Edit Profile", onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          }),
          const SizedBox(height: 24),
          sectionHeader("Preferences"),
          buildSwitchCardTile(
            icon: Icons.dark_mode,
            title: "Dark Mode",
            value: _darkMode,
            onChanged: (val) {
              setState(() => _darkMode = val);
            },
          ),
          buildSwitchCardTile(
            icon: Icons.notifications,
            title: "Push Notifications",
            value: _notifications,
            onChanged: (val) {
              setState(() => _notifications = val);
            },
          ),
          const SizedBox(height: 24),
          sectionHeader("More"),
          buildCardTile(Icons.info_outline, "About App", onTap: () {}),
          buildCardTile(Icons.logout, "Log Out", onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          }, color: Colors.redAccent),
        ],
      ),
    );
  }

  // Section Header
  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Regular Tile
  Widget buildCardTile(IconData icon, String title,
      {VoidCallback? onTap, Color color = Colors.black87}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(color: color)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // Switch Tile
  Widget buildSwitchCardTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        secondary: Icon(icon),
        title: Text(title),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
