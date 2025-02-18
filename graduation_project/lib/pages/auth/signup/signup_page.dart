import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/login/login_page.dart';
import 'package:graduation_project/pages/profile/person_module.dart';
import 'package:graduation_project/pages/profile/person_provider.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

enum ECharacteres { user, seller }

class _SignupPageState extends State<SignupPage> {
  ECharacteres? _selectedOption = ECharacteres.user;
  final _formKey = GlobalKey<FormState>();

  String? _firstNameError;
  String? _lastNameError;
  String? _userNameError;
  String? _passwordError;
  String? _confirmPasswordError;

  final TextEditingController _conFirstName = TextEditingController();
  final TextEditingController _conLastName = TextEditingController();
  final TextEditingController _conUserName = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();
  final TextEditingController _conConfirmPassword = TextEditingController();

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
                    height: 630,
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
                                          top: 20,
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
                                      top: 20,
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
                                right: 20, left: 20, top: 10, bottom: 10),
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
                                prefixIcon: const Icon(Icons.person),
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
                          Container(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 20, bottom: 10),
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
                                  prefixIcon: const Icon(Icons.lock_outline),
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
                                right: 20, left: 20, top: 20, bottom: 10),
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
                                prefixIcon: const Icon(Icons.lock_outline),
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
                          Consumer<PersonProvider>(
                              builder: (context, personList, child) {
                            return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: SizedBox(
                                    width: 300,
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          // _validateForm();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            personList.addPerson(PersonModule(
                                                personList.numberOfPersons
                                                    .toString(),
                                                _conUserName.text,
                                                "${_conFirstName.text} ${_conLastName.text}",
                                                _conPassword.text,
                                                DateTime.now()));

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage()));
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
