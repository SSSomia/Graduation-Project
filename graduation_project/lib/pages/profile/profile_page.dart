import 'package:flutter/material.dart';

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
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        'https://all-best.co/wp-content/uploads/2017/08/unnamed-file-85.jpg', // Replace with user's profile image
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Somia Mohammed',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Somia',
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Divider(),
                  const SizedBox(height: 10),
                  Text(
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    "Personal Information",
                    textAlign: TextAlign.start,
                  ),
                  ListTile(
                    title: Text("Email"),
                    subtitle: Text("somia@gmial.com"),
                    trailing: Icon(Icons.edit_outlined),
                  ),
                    ListTile(
                    title: Text("Password"),
                    subtitle: Text("*********"),
                    trailing: Icon(Icons.edit_outlined),
                  ),
                  ListTile(
                    title: Text("Phone Number"),
                    subtitle: Text("021575744"),
                    trailing: Icon(Icons.edit_outlined),
                  ),
                  ListTile(
                    title: Text("Address"),
                    subtitle: Text("almenofiya"),
                    trailing: Icon(Icons.edit_outlined),
                  ),
                  ListTile(
                    title: Text("Created at"),
                    subtitle: Text("9. 2022"),
                    trailing: Icon(Icons.edit_outlined),
                  ),
                
                  Divider()
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
