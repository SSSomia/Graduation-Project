import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project/user_data/globalUserData.dart';
import 'package:image_picker/image_picker.dart';

// have to add the image of the user and defult image
class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _selectedImage;
  final String _defaultImageUrl =
      "https://creazilla-store.fra1.digitaloceanspaces.com/icons/3251108/person-icon-md.png"; // Default image URL

//  NetworkImage('https://all-best.co/wp-content/uploads/2017/08/unnamed-file-85.jpg',),

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
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
                      child: _selectedImage != null
                          ? Image.file(_selectedImage!,
                              width: 150, height: 150, fit: BoxFit.cover)
                          : Image.network(_defaultImageUrl,
                              width: 150, height: 150, fit: BoxFit.cover),
                    ),
                    // backgroundImage: Image.file(_selectedImage!, width: 300, height: 300, fit: BoxFit.cover)),
                    const SizedBox(height: 10),
                    Text(
                      globalUser.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      globalUser.userName,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 20,
                  right: 20,
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
                      onPressed: _pickImage,
                    ),
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
                    title: const Text("Email"),
                    subtitle: globalUser.emial == ""
                        ? const Text(
                            "not added yet!",
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(globalUser.emial),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title: const Text("Password"),
                    subtitle: Text(globalUser.password),
                    trailing: const Icon(Icons.edit_outlined),
                  ),
                  ListTile(
                    title: const Text("Phone Number"),
                    subtitle: globalUser.phoneNumber == ""
                        ? const Text(
                            "not added yet!",
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(globalUser.phoneNumber),
                    trailing: const Icon(Icons.edit_outlined),
                  ),
                  ListTile(
                    title: const Text("Address"),
                    subtitle: globalUser.address == ""
                        ? const Text(
                            "not added yet!",
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(globalUser.address),
                    trailing: const Icon(Icons.edit_outlined),
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
