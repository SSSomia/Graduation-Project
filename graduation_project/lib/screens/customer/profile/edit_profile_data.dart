// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/providers/login_provider.dart';
// import 'package:graduation_project/providers/profile_provider.dart';
// import 'package:graduation_project/providers/update_profile_data.dart';
// import 'package:graduation_project/widgets/build_image.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// // have to add the image of the user and defult image
// class EditProfileData extends StatefulWidget {
//   const EditProfileData({super.key});

//   @override
//   State<EditProfileData> createState() => _EditProfileDataState();
// }

// class _EditProfileDataState extends State<EditProfileData> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final authProvider = Provider.of<LoginProvider>(context, listen: false);
//       Provider.of<ProfileProvider>(context, listen: false)
//           .fetchProfile(authProvider.token);
//     });
//   }

//   File? _selectedImage;
//   final ImagePicker _picker = ImagePicker();

//   // Future<void> _pickImage() async {
//   //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//   //   if (pickedFile != null) {
//   //     setState(() {
//   //       _selectedImage = File(pickedFile.path);
//   //     });
//   //     // can't save the image in user data
//   //     user.image = pickedFile.path;
//   //     // user.image = _selectedImage;
//   //   }
//   // }

//   void _showInputDialog(
//       String title, String initialValue, Function(String) onSubmit) {
//     TextEditingController textController =
//         TextEditingController(text: initialValue);

//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Consumer<ProfileProvider>(
//               builder: (context, profileProvider, _) {
//             final user = profileProvider.userProfile!;
//             return AlertDialog(
//                 title: Text("Enter $title"),
//                 content: TextField(
//                   controller: textController,
//                   decoration: InputDecoration(hintText: "Enter new $title"),
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text("Cancel"),
//                   ),
//                   Consumer<UpdateProfileData>(
//                       builder: (context, updateProfile, child) {
//                     return TextButton(
//                       onPressed: () async {
//                         final loginToken =
//                             Provider.of<LoginProvider>(context, listen: false);
//                         final String token = loginToken.token;
//                         List<String> names = user.name.trim().split(' ');
//                         String firstName = names.isNotEmpty ? names[0] : '';
//                         String lastName =
//                             names.length > 1 ? names.sublist(1).join(' ') : '';
//                         if (title == 'User name') {
//                           final result = await updateProfile.updateProfile(
//                               FirstN: firstName,
//                               LastN: lastName,
//                               Email: user.email,
//                               UserN: textController.text,
//                               profileImage0: null,
//                               token: token);
//                         } else if (title == 'First Name') {
//                           final result = await updateProfile.updateProfile(
//                               FirstN: textController.text,
//                               LastN: lastName,
//                               Email: user.email,
//                               UserN: user.UserName,
//                               profileImage0: null,
//                               token: token);
//                           user.name = '${textController.text} $lastName';
//                           // if (result) {
//                           // }
//                         } else if (title == 'Last Name') {
//                           final result = await updateProfile.updateProfile(
//                               FirstN: firstName,
//                               LastN: textController.text,
//                               Email: user.email,
//                               UserN: user.UserName,
//                               profileImage0: null,
//                               token: token);
//                           if (result) {
//                             user.name = '$firstName ${textController.text}';
//                           }
//                         } else if (title == 'Email') {
//                           final result = await updateProfile.updateProfile(
//                               FirstN: firstName,
//                               LastN: lastName,
//                               Email: textController.text,
//                               UserN: user.UserName,
//                               profileImage0: null,
//                               token: token);
//                         }
//                         Navigator.of(context).pop();
//                         setState(() {
//                           onSubmit(textController.text); // Update dynamically
//                         });
//                       },
//                       child: const Text("OK"),
//                     );
//                   })
//                 ]);
//           });
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("My Profile"),
//           backgroundColor: const Color.fromARGB(255, 238, 249, 250),
//         ),
//         body: Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
//           if (profileProvider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (profileProvider.error != null) {
//             return Center(child: Text('Error: ${profileProvider.error}'));
//           } else if (profileProvider.userProfile != null) {
//             final user = profileProvider.userProfile!;

//             List<String> names = user.name.trim().split(' ');
//             String firstName = names.isNotEmpty ? names[0] : '';
//             String lastName =
//                 names.length > 1 ? names.sublist(1).join(' ') : '';
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   // Profile Header
//                   Stack(children: [
//                     Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: const BoxDecoration(
//                         color: Color.fromARGB(255, 3, 117, 138),
//                         borderRadius: BorderRadius.all(Radius.circular(40)),
//                       ),
//                       child: Column(
//                         children: [
//                           CircleAvatar(
//                             radius: 60,
//                             backgroundColor: Colors.grey[200],
//                             child: ClipOval(
//                               child: SizedBox(
//                                 width: 120, // 2 * radius
//                                 height: 120,
//                                 child: FittedBox(
//                                   fit: BoxFit.cover,
//                                   child: buildImage(user.imageurl),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             user.UserName,
//                             style: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                         top: 10,
//                         right: 10,
//                         child: Container(
//                             decoration: const BoxDecoration(
//                               //color: Colors.white,
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color.fromARGB(155, 255, 255, 255),
//                                   blurRadius: 6,
//                                   offset: Offset(3, 3),
//                                 ),
//                               ],
//                             ),
//                             child: Consumer<UpdateProfileData>(
//                                 builder: (context, updateProfile, child) {
//                               return IconButton(
//                                   icon: const Icon(Icons.edit_outlined),
//                                   onPressed:
//                                       //  _pickImage
//                                       () async {
//                                     final pickedFile = await _picker.pickImage(
//                                         source: ImageSource.gallery);

//                                     if (pickedFile != null) {
//                                       setState(() {
//                                         _selectedImage = File(pickedFile.path);
//                                       });
//                                       // can't save the image in user data
//                                       user.imageurl = pickedFile.path;
//                                       // user.image = _selectedImage;
//                                     }

//                                     final loginToken =
//                                         Provider.of<LoginProvider>(context,
//                                             listen: false);
//                                     final String token = loginToken.token;
//                                     await updateProfile.updateProfile(
//                                         FirstN: firstName,
//                                         LastN: lastName,
//                                         Email: user.email,
//                                         UserN: user.UserName,
//                                         profileImage0: _selectedImage,
//                                         token: token);
//                                   });
//                             }))),
//                     Positioned(
//                         bottom: 10,
//                         right: 10,
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             //color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Color.fromARGB(155, 255, 255, 255),
//                                 blurRadius: 12,
//                                 offset: Offset(3, 3),
//                               ),
//                             ],
//                           ),
//                           child: IconButton(
//                               icon: const Icon(Icons.edit_outlined),
//                               onPressed: () {
//                                 setState(() {
//                                   _showInputDialog("User name", user.UserName,
//                                       (newValue) {
//                                     user.UserName = newValue;
//                                   });
//                                 });
//                               }),
//                         )),
//                   ]),
//                   const SizedBox(height: 15),

//                   // Profile Details
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Column(children: [
//                       const Divider(),
//                       const SizedBox(height: 10),
//                       const Text(
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18),
//                         "Personal Information",
//                         textAlign: TextAlign.start,
//                       ),
//                       ListTile(
//                           title: const Text("First Name"),
//                           subtitle: Text(firstName),
//                           trailing: IconButton(
//                               icon: const Icon(Icons.edit_outlined),
//                               onPressed: () {
//                                 setState(() {
//                                   _showInputDialog("First Name", firstName,
//                                       (newValue) {
//                                     firstName = newValue;
//                                   });
//                                 });
//                               })),
//                       ListTile(
//                           title: const Text("Last Name"),
//                           subtitle: Text(lastName),
//                           trailing: IconButton(
//                               icon: const Icon(Icons.edit_outlined),
//                               onPressed: () {
//                                 setState(() {
//                                   _showInputDialog("Last Name", lastName,
//                                       (newValue) {
//                                     lastName = newValue;
//                                   });
//                                 });
//                               })),
//                       ListTile(
//                           title: const Text("Email"),
//                           subtitle: user.email == ""
//                               ? const Text(
//                                   "not added yet!",
//                                   style: TextStyle(color: Colors.grey),
//                                 )
//                               : Text(user.email),
//                           trailing: IconButton(
//                               icon: const Icon(Icons.edit_outlined),
//                               onPressed: () {
//                                 setState(() {
//                                   _showInputDialog("Email", user.email,
//                                       (newValue) {
//                                     user.email = newValue;
//                                   });
//                                 });
//                               })),
//                     ]),
//                   ),

//                   // Logout Button
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text("No profile data found."));
//           }
//         }));
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/profile_provider.dart';
import 'package:graduation_project/providers/update_profile_data.dart';
import 'package:graduation_project/widgets/build_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileData extends StatefulWidget {
  const EditProfileData({super.key});

  @override
  State<EditProfileData> createState() => _EditProfileDataState();
}

class _EditProfileDataState extends State<EditProfileData> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<ProfileProvider>(context, listen: false)
          .fetchProfile(authProvider.token);
    });
  }

  void _showInputDialog(
      String title, String initialValue, Function(String) onSubmit) {
    TextEditingController textController =
        TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<ProfileProvider>(
            builder: (context, profileProvider, _) {
          final user = profileProvider.userProfile!;
          return AlertDialog(
            title: Text("Enter $title"),
            content: TextField(
              controller: textController,
              decoration: InputDecoration(hintText: "Enter new $title"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              Consumer<UpdateProfileData>(
                  builder: (context, updateProfile, child) {
                return TextButton(
                  onPressed: () async {
                    final loginToken =
                        Provider.of<LoginProvider>(context, listen: false);
                    final String token = loginToken.token;
                    List<String> names = user.name.trim().split(' ');
                    String firstName = names.isNotEmpty ? names[0] : '';
                    String lastName =
                        names.length > 1 ? names.sublist(1).join(' ') : '';
                    if (title == 'User name') {
                      await updateProfile.updateProfile(
                        FirstN: firstName,
                        LastN: lastName,
                        Email: user.email,
                        UserN: textController.text,
                        profileImage0: null,
                        token: token,
                      );
                    } else if (title == 'First Name') {
                      await updateProfile.updateProfile(
                        FirstN: textController.text,
                        LastN: lastName,
                        Email: user.email,
                        UserN: user.UserName,
                        profileImage0: null,
                        token: token,
                      );
                      user.name = '${textController.text} $lastName';
                    } else if (title == 'Last Name') {
                      await updateProfile.updateProfile(
                        FirstN: firstName,
                        LastN: textController.text,
                        Email: user.email,
                        UserN: user.UserName,
                        profileImage0: null,
                        token: token,
                      );
                      user.name = '$firstName ${textController.text}';
                    } else if (title == 'Email') {
                      await updateProfile.updateProfile(
                        FirstN: firstName,
                        LastN: lastName,
                        Email: textController.text,
                        UserN: user.UserName,
                        profileImage0: null,
                        token: token,
                      );
                    }
                    Navigator.of(context).pop();
                    setState(() {
                      onSubmit(textController.text);
                    });
                  },
                  child: const Text("OK"),
                );
              })
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: const Color(0xFFEFFBFB),
      ),
      body: Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
        if (profileProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (profileProvider.error != null) {
          return Center(child: Text('Error: ${profileProvider.error}'));
        } else if (profileProvider.userProfile != null) {
          final user = profileProvider.userProfile!;
          List<String> names = user.name.trim().split(' ');
          String firstName = names.isNotEmpty ? names[0] : '';
          String lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0598B1), Color(0xFF035B70)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  // decoration: const BoxDecoration(
                  //   color: Color(0xFF03758A),
                  //   borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(30),
                  //     bottomRight: Radius.circular(30),
                  //   ),
                  // ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: buildImage(user.imageurl),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt, size: 20),
                                onPressed: () async {
                                  final pickedFile = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (pickedFile != null) {
                                    setState(() {
                                      _selectedImage = File(pickedFile.path);
                                      user.imageurl = pickedFile.path;
                                    });

                                    final token = Provider.of<LoginProvider>(
                                            context,
                                            listen: false)
                                        .token;
                                    await Provider.of<UpdateProfileData>(
                                            context,
                                            listen: false)
                                        .updateProfile(
                                      FirstN: firstName,
                                      LastN: lastName,
                                      Email: user.email,
                                      UserN: user.UserName,
                                      profileImage0: _selectedImage,
                                      token: token,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user.UserName,
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

                // Personal Info Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildInfoCard(
                        title: "First Name",
                        value: firstName,
                        icon: Icons.person,
                        onEdit: () {
                          _showInputDialog("First Name", firstName,
                              (newValue) => firstName = newValue);
                        },
                      ),
                      _buildInfoCard(
                        title: "Last Name",
                        value: lastName,
                        icon: Icons.person_outline,
                        onEdit: () {
                          _showInputDialog("Last Name", lastName,
                              (newValue) => lastName = newValue);
                        },
                      ),
                      _buildInfoCard(
                        title: "Email",
                        value:
                            user.email.isEmpty ? "Not added yet" : user.email,
                        icon: Icons.email_outlined,
                        onEdit: () {
                          _showInputDialog("Email", user.email,
                              (newValue) => user.email = newValue);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        } else {
          return const Center(child: Text("No profile data found."));
        }
      }),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onEdit,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 15),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.grey),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
