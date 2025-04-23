import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/register.dart';
import 'package:graduation_project/api_providers/register_provider.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:graduation_project/screens/auth/other_user_data.dart';
import 'package:graduation_project/models/person_module.dart';
import 'package:graduation_project/providers/person_provider.dart';
import 'package:graduation_project/screens/auth/seller_market_data.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

enum ECharacteres { user, seller }

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  String? _firstNameError;
  String? _lastNameError;
  String? _userNameError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _emailError;
  ECharacteres? _selectedOption = ECharacteres.user;

  final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  final TextEditingController _conFirstName = TextEditingController();
  final TextEditingController _conLastName = TextEditingController();
  final TextEditingController _conUserName = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();
  final TextEditingController _conConfirmPassword = TextEditingController();
  final TextEditingController _conEmail = TextEditingController();

  @override
  void dispose() {
    _conFirstName.dispose();
    _conLastName.dispose();
    _conUserName.dispose();
    _conPassword.dispose();
    _conConfirmPassword.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _firstNameError =
          _conFirstName.text.isEmpty ? "Please enter your first name" : null;
      _lastNameError =
          _conLastName.text.isEmpty ? "Please enter your last name" : null;
      _userNameError =
          _conUserName.text.isEmpty ? "Please enter your username" : null;
      _passwordError = _conPassword.text.isEmpty
          ? "Please enter your password"
          : (_conPassword.text.length < 6
              ? "Password must be at least 6 characters"
              : null);
      _confirmPasswordError = _conConfirmPassword.text.isEmpty
          ? "Please confirm your password"
          : (_conPassword.text != _conConfirmPassword.text
              ? "Passwords do not match"
              : null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 93, 146, 152),
            body: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  Container(
                    width: 350,
                    height: 650,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 123, 123, 123)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'SIGN UP',
                            style: TextStyle(
                                fontSize: 50,
                                color: Color.fromARGB(255, 0, 104, 115),
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 90,
                                        width: 175,
                                        padding: const EdgeInsets.only(
                                          right: 5,
                                          left: 20,
                                          top: 10,
                                        ),
                                        child: TextFormField(
                                          controller: _conFirstName,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter your first name";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'First Name',
                                            prefixIcon: const Icon(
                                                Icons.person_2_outlined),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            errorText: _firstNameError,
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              _firstNameError = value.isEmpty
                                                  ? "Please enter your first name"
                                                  : null;
                                            });
                                          },
                                        ),
                                      )
                                    ]),
                                Row(children: [
                                  Container(
                                    height: 90,
                                    width: 175,
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                      // left: 20,
                                      top: 10,
                                    ),
                                    child: TextFormField(
                                      controller: _conLastName,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your last name";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Last Name',
                                        prefixIcon:
                                            const Icon(Icons.person_2_outlined),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        errorText: _lastNameError,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          _lastNameError = value.isEmpty
                                              ? "Please enter your last name"
                                              : null;
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                              ]),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 0, bottom: 10),
                            child: TextFormField(
                              controller: _conUserName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a username";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Username',
                                prefixIcon: const Icon(Icons.person_2_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorText: _userNameError,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _userNameError = value.isEmpty
                                      ? "Please enter your username"
                                      : null;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: TextFormField(
                              controller: _conEmail,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a email";
                                } else if (!emailRegExp.hasMatch(value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorText: _emailError,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _emailError = value.isEmpty
                                      ? "Please enter your email"
                                      : null;
                                });
                              },
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 10, bottom: 10),
                              child: TextFormField(
                                controller: _conPassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a password";
                                  } else if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon:
                                      const Icon(Icons.password_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  errorText: _passwordError,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _passwordError = value.isEmpty
                                        ? "Please enter your password"
                                        : (value.length < 6
                                            ? "Password must be at least 6 characters"
                                            : null);
                                  });
                                },
                              )),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 10, bottom: 10),
                            child: TextFormField(
                              controller: _conConfirmPassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please confirm your password";
                                } else if (value != _conPassword.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: const Icon(Icons.password_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorText: _confirmPasswordError,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _confirmPasswordError = value.isEmpty
                                      ? "Please confirm your password"
                                      : (_conPassword.text != value
                                          ? "Passwords do not match"
                                          : null);
                                });
                              },
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<ECharacteres>(
                                      value: ECharacteres.user,
                                      groupValue: _selectedOption,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedOption = value;
                                        });
                                      },
                                    ),
                                    const Text('User',
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<ECharacteres>(
                                      value: ECharacteres.seller,
                                      groupValue: _selectedOption,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedOption = value;
                                        });
                                      },
                                    ),
                                    const Text('Seller',
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Consumer<UserProvider>(
                              builder: (context, userProvider, child) {
                            return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: SizedBox(
                                    width: 300,
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          // _validateForm();

                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (_selectedOption ==
                                                ECharacteres.user) {
                                              await userProvider.register(
                                                user: User(
                                                  FirstName: _conFirstName.text,
                                                  LastName: _conLastName.text,
                                                  UserName: _conUserName.text,
                                                  Email: _conEmail.text,
                                                  Password: _conPassword.text,
                                                  Role: 0,
                                                ),
                                              );

                                              if (userProvider
                                                  .isAuthenticated) {
                                                print("every thing is good");
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Login successful!')),
                                                );
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         const LoginPage(),
                                                //   ),
                                                // );
                                                // Navigate to the next screen or show success message
                                              } else {
                                                print("an error accure");
                                                // Show error message
                                              }

                                              // personList.addPerson(PersonModule(
                                              //     personList.numberOfPersons
                                              //         .toString(),
                                              //     _conUserName.text,
                                              //     "${_conFirstName.text} ${_conLastName.text}",
                                              //     _conPassword.text,
                                              //     DateTime.now(),
                                              //     _conEmail.text,
                                              //     _selectedOption.toString()));
                                            } else {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         SellerMarketData(
                                              //             person: PersonModule(
                                              //                 personList
                                              //                     .numberOfPersons
                                              //                     .toString(),
                                              //                 _conUserName.text,
                                              //                 "${_conFirstName.text} ${_conLastName.text}",
                                              //                 _conPassword.text,
                                              //                 DateTime.now(),
                                              //                 _conEmail.text,
                                              //                 _selectedOption
                                              //                     .toString())),
                                              // ),
                                              // );
                                              //  Navigator.push(
                                              // context,
                                              // MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         LoginPage()));
                                            }
                                            // personList.addPerson(PersonModule(
                                            //     personList.numberOfPersons
                                            //         .toString(),
                                            //     _conUserName.text,
                                            //     "${_conFirstName.text} ${_conLastName.text}",
                                            //     _conPassword.text,
                                            //     DateTime.now(), _conEmail.text, _selectedOption.toString()));

                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             OtherUserData(
                                            //                 userName:
                                            //                     _conUserName
                                            //                         .text,
                                            //                 name:
                                            //                     '${_conFirstName.text} ${_conLastName.text}',
                                            //                 password:
                                            //                     _conPassword
                                            //                         .text,
                                            //                 createdAt:
                                            //                     DateTime.now(),
                                            //                 role:
                                            //                     widget.role)));

                                            // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                            // sharedPreferences.setString("userName", "")
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 3, 88, 98),
                                          foregroundColor: const Color.fromARGB(
                                              255,
                                              255,
                                              255,
                                              255), // Text (foreground) color of the button
                                        ),
                                        child: const Text(
                                          'Sign Up',
                                          style: TextStyle(fontSize: 20),
                                        ))));
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('You have an account?'),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                  },
                                  child: const Text('Login'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ])))));
  }
}
