import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/profile_provider.dart';
import 'package:graduation_project/providers/update_profile_data.dart';
import 'package:graduation_project/widgets/build_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// have to add the image of the user and defult image
class EditProfileData extends StatefulWidget {
  const EditProfileData({super.key});

  @override
  State<EditProfileData> createState() => _EditProfileDataState();
}

class _EditProfileDataState extends State<EditProfileData> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<ProfileProvider>(context, listen: false)
          .fetchProfile(authProvider.token);
    });
  }

  File? _selectedImage;
 final ImagePicker _picker = ImagePicker();

  // Future<void> _pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _selectedImage = File(pickedFile.path);
  //     });
  //     // can't save the image in user data
  //     user.image = pickedFile.path;
  //     // user.image = _selectedImage;
  //   }
  // }

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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
                          final result = await updateProfile.updateProfile(
                              FirstN: firstName,
                              LastN: lastName,
                              Email: user.email,
                              UserN: textController.text,
                              profileImage0: null,
                              token: token);
                        } else if (title == 'First Name') {
                          final result = await updateProfile.updateProfile(
                              FirstN: textController.text,
                              LastN: lastName,
                              Email: user.email,
                              UserN: user.UserName,
                              profileImage0: null,
                              token: token);
                          user.name = '${textController.text} $lastName';
                          // if (result) {
                          // }
                        } else if (title == 'Last Name') {
                          final result = await updateProfile.updateProfile(
                              FirstN: firstName,
                              LastN: textController.text,
                              Email: user.email,
                              UserN: user.UserName,
                              profileImage0: null,
                              token: token);
                          if (result) {
                            user.name = '$firstName ${textController.text}';
                          }
                        } else if (title == 'Email') {
                          final result = await updateProfile.updateProfile(
                              FirstN: firstName,
                              LastN: lastName,
                              Email: textController.text,
                              UserN: user.UserName,
                              profileImage0: null,
                              token: token);
                        }
                        Navigator.of(context).pop();
                        setState(() {
                          onSubmit(textController.text); // Update dynamically
                        });
                      },
                      child: const Text("OK"),
                    );
                  })
                ]);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Profile"),
          backgroundColor: const Color.fromARGB(255, 238, 249, 250),
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
            String lastName =
                names.length > 1 ? names.sublist(1).join(' ') : '';
            return SingleChildScrollView(
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
                            backgroundColor: Colors.grey[200],
                            child: ClipOval(
                              child: SizedBox(
                                width: 120, // 2 * radius
                                height: 120,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: buildImage(user.imageurl),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            user.UserName,
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
                            child: Consumer<UpdateProfileData>(
                                builder: (context, updateProfile, child) {
                              return IconButton(
                                  icon: const Icon(Icons.edit_outlined),
                                  onPressed:
                                      //  _pickImage
                                      () async {
                                    final pickedFile = await _picker.pickImage(
                                        source: ImageSource.gallery);

                                    if (pickedFile != null) {
                                      setState(() {
                                        _selectedImage = File(pickedFile.path);
                                      });
                                      // can't save the image in user data
                                      user.imageurl = pickedFile.path;
                                      // user.image = _selectedImage;
                                    }

                                    final loginToken =
                                        Provider.of<LoginProvider>(context,
                                            listen: false);
                                    final String token = loginToken.token;
                                    await updateProfile.updateProfile(
                                        FirstN: firstName,
                                        LastN: lastName,
                                        Email: user.email,
                                        UserN: user.UserName,
                                        profileImage0: _selectedImage,
                                        token: token);
                                  });
                            }))),
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
                                  _showInputDialog("User name", user.UserName,
                                      (newValue) {
                                    user.UserName = newValue;
                                  });
                                });
                              }),
                        )),
                  ]),
                  const SizedBox(height: 15),

                  // Profile Details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(children: [
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        "Personal Information",
                        textAlign: TextAlign.start,
                      ),
                      ListTile(
                          title: const Text("First Name"),
                          subtitle: Text(firstName),
                          trailing: IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () {
                                setState(() {
                                  _showInputDialog("First Name", firstName,
                                      (newValue) {
                                    firstName = newValue;
                                  });
                                });
                              })),
                      ListTile(
                          title: const Text("Last Name"),
                          subtitle: Text(lastName),
                          trailing: IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () {
                                setState(() {
                                  _showInputDialog("Last Name", lastName,
                                      (newValue) {
                                    lastName = newValue;
                                  });
                                });
                              })),
                      ListTile(
                          title: const Text("Email"),
                          subtitle: user.email == ""
                              ? const Text(
                                  "not added yet!",
                                  style: TextStyle(color: Colors.grey),
                                )
                              : Text(user.email),
                          trailing: IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () {
                                setState(() {
                                  _showInputDialog("Email", user.email,
                                      (newValue) {
                                    user.email = newValue;
                                  });
                                });
                              })),
                      // ListTile(
                      //   title: const Text("Password"),
                      //   subtitle: Text(user.),
                      //   trailing: IconButton(
                      //     icon: const Icon(Icons.edit_outlined),
                      //     onPressed: () {
                      //       _showInputDialog(
                      //           "Password", user.,
                      //           (newValue) {
                      //         user. = newValue;
                      //       });
                      //     },
                      //   ),
                      // ),
                      // ListTile(
                      //   title: const Text("Phone Number"),
                      //   subtitle: user.userPhone == ""
                      //       ? const Text(
                      //           "not added yet!",
                      //           style: TextStyle(color: Colors.grey),
                      //         )
                      //       : Text(user.userPhone),
                      //   trailing: IconButton(
                      //     icon: const Icon(Icons.edit_outlined),
                      //     onPressed: () {
                      //       _showInputDialog(
                      //           "Phone Number", user.userPhone,
                      //           (newValue) {
                      //         user.userPhone = newValue;
                      //       });
                      //     },
                      //   ),
                      // ),
                      // ListTile(
                      //   title: const Text("Address"),
                      //   subtitle: user.userAddress == ""
                      //       ? const Text(
                      //           "not added yet!",
                      //           style: TextStyle(color: Colors.grey),
                      //         )
                      //       : Text(user.userAddress),
                      //   trailing: IconButton(
                      //     icon: const Icon(Icons.edit_outlined),
                      //     onPressed: () {
                      //       _showInputDialog("Address", user.userAddress,
                      //           (newValue) {
                      //         user.userAddress = newValue;
                      //       });
                      //     },
                      //   ),
                      // ),
                      // ListTile(
                      //   title: const Text("Created at"),
                      //   subtitle: Text(
                      //       user.createdAt.toString().substring(0, 10)),
                      // ),
                      const Divider(),
                      // user.isSeller
                      //     ? Column(
                      //         children: [
                      //           const SizedBox(height: 10),
                      //           const Text(
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 18),
                      //             "Store Information",
                      //             textAlign: TextAlign.start,
                      //           ),
                      //           ListTile(
                      //             title: const Text("Name"),
                      //             subtitle: user.marketName == ""
                      //                 ? const Text(
                      //                     "not added yet!",
                      //                     style: TextStyle(color: Colors.grey),
                      //                   )
                      //                 : Text(user.marketName),
                      //             trailing: IconButton(
                      //               icon: const Icon(Icons.edit_outlined),
                      //               onPressed: () {
                      //                 _showInputDialog(
                      //                     "Store Name", user.marketName,
                      //                     (newValue) {
                      //                   user.marketName = newValue;
                      //                 });
                      //               },
                      //             ),
                      //           ),
                      //           ListTile(
                      //             title: const Text("Address"),
                      //             subtitle: user.marketAddress == ""
                      //                 ? const Text(
                      //                     "not added yet!",
                      //                     style: TextStyle(color: Colors.grey),
                      //                   )
                      //                 : Text(user.marketAddress),
                      //             trailing: IconButton(
                      //               icon: const Icon(Icons.edit_outlined),
                      //               onPressed: () {
                      //                 _showInputDialog("Store Address",
                      //                     user.marketAddress, (newValue) {
                      //                   user.marketAddress = newValue;
                      //                 });
                      //               },
                      //             ),
                      //           ),
                      //           ListTile(
                      //             title: const Text("Description"),
                      //             subtitle: user.marketDescription == ""
                      //                 ? const Text(
                      //                     "not added yet!",
                      //                     style: TextStyle(color: Colors.grey),
                      //                   )
                      //                 : Text(user.marketDescription),
                      //             trailing: IconButton(
                      //               icon: const Icon(Icons.edit_outlined),
                      //               onPressed: () {
                      //                 _showInputDialog("Description",
                      //                     user.marketDescription,
                      //                     (newValue) {
                      //                   user.marketDescription = newValue;
                      //                 });
                      //               },
                      //             ),
                      //           ),
                      //     const Divider(),
                      //   ],
                      // )
                      // : SizedBox(
                      //     height: 0,
                      //   )
                    ]),
                  ),

                  // Logout Button
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No profile data found."));
          }
        }));
  }
}
