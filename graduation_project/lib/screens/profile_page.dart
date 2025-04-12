import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:graduation_project/user_data/globalUserData.dart';

class You extends StatelessWidget {
  const You({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Profile Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 5, 152, 177),
                              Color(0xFF035B70)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: (globalUser.image != null &&
                                      globalUser.image.isNotEmpty &&
                                      File(globalUser.image).existsSync())
                                  ? FileImage(File(globalUser.image))
                                  : const AssetImage(
                                          "assets/images/profileDefultImage/defultImage.png")
                                      as ImageProvider,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              globalUser.userName,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Personal Info Card
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Personal Information",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                buildInfoTile("Name", globalUser.name),
                                buildInfoTile("Email", globalUser.userEmail),
                                buildInfoTile(
                                    "Password", globalUser.userPassword),
                                buildInfoTile("Phone", globalUser.userPhone),
                                buildInfoTile(
                                    "Address", globalUser.userAddress),
                                buildInfoTile(
                                    "Created At",
                                    globalUser.createdAt
                                        .toString()
                                        .substring(0, 10)),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Store Info Card
                      if (globalUser.isSeller)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Personal Information",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  buildInfoTile("Name", globalUser.name),
                                  buildInfoTile("Email", globalUser.userEmail),
                                  buildInfoTile("Phone", globalUser.userPhone),
                                  buildInfoTile(
                                      "Address", globalUser.userAddress),
                                  buildInfoTile(
                                      "Created At",
                                      globalUser.createdAt
                                          .toString()
                                          .substring(0, 10)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      const Spacer(),
                      const SizedBox(
                        height: 10,
                      ),
                      // Logout Button
                      SizedBox(
                        width: 200, // 👈 set custom width here
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false,
                            );
                            // your logout logic
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text("Logout"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildInfoTile(String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        value.isEmpty ? "Not added yet!" : value,
        style: TextStyle(color: value.isEmpty ? Colors.grey : Colors.black87),
      ),
    );
  }
}
