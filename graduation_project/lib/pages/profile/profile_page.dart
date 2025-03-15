import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/login/login_page.dart';
import 'package:graduation_project/pages/profile/change_user_data.dart';
import 'package:graduation_project/user_data/globalUserData.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// have to add the image of the user and defult image
class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _selectedImage;
  // final String _defaultImageUrl =
  //     "https://creazilla-store.fra1.digitaloceanspaces.com/icons/3251108/person-icon-md.png";
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      // can't save the image in user data
      globalUser.image = pickedFile.path;
      // globalUser.image = _selectedImage;
    }
  }

  void _showInputDialog(
      String title, String initialValue, Function(String) onSubmit) {
    TextEditingController textController =
        TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter $title"),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(hintText: "Enter new $title"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  onSubmit(textController.text); // Update dynamically
                });
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // Profile Header
            Stack(children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 3, 117, 138),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      //   backgroundImage: _selectedImage != null
                      //       ? FileImage(_selectedImage!) // Show selected image
                      //       : (globalUser.image != null &&
                      //                   globalUser.image.isNotEmpty
                      //               ? FileImage(File(
                      //                   globalUser.image)) // Show saved image
                      //               : AssetImage(
                      //                   "assets/images/profileDefultImage/defultImage.png"))
                      //           as ImageProvider, // Show default image
                      // ),

                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!) // Show selected image
                          : (globalUser.image != null &&
                                  globalUser.image.isNotEmpty &&
                                  File(globalUser.image).existsSync()
                              ? FileImage(
                                  File(globalUser.image)) // Show saved image
                              : const AssetImage(
                                  "assets/images/profileDefultImage/defultImage.png")),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      globalUser.userName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      //color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(155, 255, 255, 255),
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: _pickImage),
                  )),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      //color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(155, 255, 255, 255),
                          blurRadius: 12,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () {
                          setState(() {
                            _showInputDialog("User name", globalUser.userName,
                                (newValue) {
                              globalUser.userName = newValue;
                            });
                          });
                        }),
                  )),
            ]),
            const SizedBox(height: 15),

            // Profile Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    "Personal Information",
                    textAlign: TextAlign.start,
                  ),
                  ListTile(
                      title: const Text("Name"),
                      subtitle: Text(globalUser.name),
                      trailing: IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () {
                            setState(() {
                              _showInputDialog("Name", globalUser.userEmail,
                                  (newValue) {
                                globalUser.name = newValue;
                              });
                            });
                          })),
                  ListTile(
                      title: const Text("Email"),
                      subtitle: globalUser.userEmail == ""
                          ? const Text(
                              "not added yet!",
                              style: TextStyle(color: Colors.grey),
                            )
                          : Text(globalUser.userEmail),
                      trailing: IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () {
                            setState(() {
                              _showInputDialog("Email", globalUser.userEmail,
                                  (newValue) {
                                globalUser.userEmail = newValue;
                              });
                            });
                          })),
                  ListTile(
                    title: const Text("Password"),
                    subtitle: Text(globalUser.userPassword),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {
                        _showInputDialog("Password", globalUser.userPassword,
                            (newValue) {
                          globalUser.userPassword = newValue;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Phone Number"),
                    subtitle: globalUser.userPhone == ""
                        ? const Text(
                            "not added yet!",
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(globalUser.userPhone),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {
                        _showInputDialog("Phone Number", globalUser.userPhone,
                            (newValue) {
                          globalUser.userPhone = newValue;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Address"),
                    subtitle: globalUser.userAddress == ""
                        ? const Text(
                            "not added yet!",
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(globalUser.userAddress),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {
                        _showInputDialog("Address", globalUser.userAddress,
                            (newValue) {
                          globalUser.userAddress = newValue;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Created at"),
                    subtitle:
                        Text(globalUser.createdAt.toString().substring(0, 10)),
                  ),
                  const Divider()
                ],
              ),
            ),

            // Logout Button
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout action
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 204, 45, 45),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
