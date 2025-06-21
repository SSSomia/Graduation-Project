// import 'package:flutter/material.dart';
// import 'package:graduation_project/screens/customer/about.dart';
// import 'package:graduation_project/screens/auth/change_password_page.dart';
// import 'package:graduation_project/screens/auth/login_page.dart';
// import 'package:graduation_project/screens/customer/profile/edit_profile_data.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool _darkMode = false;
//   bool _notifications = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Settings"),
//         backgroundColor: const Color.fromARGB(255, 255, 247, 247),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           sectionHeader("Account"),
//           buildCardTile(Icons.person, "Edit Profile", onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => EditProfileData()));
//           }),
//           buildCardTile(Icons.person, "Change Password", onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => ChangePasswordPage()));
//           }),
//           const SizedBox(height: 24),
//           sectionHeader("More"),
//           buildCardTile(Icons.info_outline, "About App", onTap: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => AboutPage()));
//           }),
//           buildCardTile(Icons.logout, "Log Out", onTap: () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => const LoginPage()),
//               (route) => false,
//             );
//           }, color: Colors.redAccent),
//         ],
//       ),
//     );
//   }

//   // Section Header
//   Widget sectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//       ),
//     );
//   }

//   // Regular Tile
//   Widget buildCardTile(IconData icon, String title,
//       {VoidCallback? onTap, Color color = Colors.black87}) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 3,
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: ListTile(
//         leading: Icon(icon, color: color),
//         title: Text(title, style: TextStyle(color: color)),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: onTap,
//       ),
//     );
//   }

//   // Switch Tile
//   Widget buildSwitchCardTile({
//     required IconData icon,
//     required String title,
//     required bool value,
//     required ValueChanged<bool> onChanged,
//   }) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 3,
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: SwitchListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//         secondary: Icon(icon),
//         title: Text(title),
//         value: value,
//         onChanged: onChanged,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation_project/screens/customer/about.dart';
import 'package:graduation_project/screens/auth/change_password_page.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:graduation_project/screens/customer/profile/edit_profile_data.dart';

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
      backgroundColor: const Color.fromARGB(255, 248, 244, 244),
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          sectionHeader("Account"),
          buildCardTile(
            icon: Icons.person,
            title: "Edit Profile",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileData()),
            ),
          ),
          buildCardTile(
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangePasswordPage()),
            ),
          ),
          const SizedBox(height: 24),
          sectionHeader("More"),
          buildCardTile(
            icon: Icons.info_outline,
            title: "About App",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutPage()),
            ),
          ),
          const SizedBox(height: 16),
          buildCardTile(
            icon: Icons.logout,
            title: "Log Out",
            color: Colors.red,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildCardTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color color = Colors.black87,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget buildSwitchCardTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
