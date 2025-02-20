import 'package:flutter/material.dart';
import 'package:graduation_project/user_data/globalUserData.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                      backgroundImage: NetworkImage(
                        'https://all-best.co/wp-content/uploads/2017/08/unnamed-file-85.jpg', // Replace with user's profile image
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      globalUser.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      globalUser.userName,
                      style: TextStyle(
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
                          color: Color.fromARGB(167, 255, 255, 255),
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.edit_outlined),
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
                        ? Text("not added yet!")
                        : Text(globalUser.emial),
                    trailing: const Icon(Icons.edit_outlined),
                  ),
                  ListTile(
                    title: Text("Password"),
                    subtitle: Text(globalUser.password),
                    trailing: Icon(Icons.edit_outlined),
                  ),
                  ListTile(
                    title: Text("Phone Number"),
                    subtitle:globalUser.phoneNumber == ""
                        ? Text("not added yet!")
                        : Text(globalUser.phoneNumber),
                    trailing: Icon(Icons.edit_outlined),
                  ),
                  ListTile(
                    title: Text("Address"),
                    subtitle: globalUser.address == ""
                        ? Text("not added yet!")
                        :Text(globalUser.address),
                    trailing: Icon(Icons.edit_outlined),
                  ),
                  ListTile(
                    title: Text("Created at"),
                    subtitle: Text(globalUser.createdAt.toString().substring(0, 10)),
                    trailing: Icon(Icons.edit_outlined),
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
