import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:graduation_project/api_providers/login_provider.dart';
import 'package:graduation_project/models/seller_model.dart';
import 'package:graduation_project/screens/auth/before_signup.dart';
import 'package:graduation_project/screens/auth/forget_pawword.dart';
import 'package:graduation_project/screens/home_page.dart';
import 'package:graduation_project/screens/mainPage.dart';
import 'package:graduation_project/screens/auth/signup_page.dart';
import 'package:graduation_project/models/person_module.dart';
import 'package:graduation_project/providers/person_provider.dart';
import 'package:graduation_project/providers/sellers_provider.dart';
import 'package:graduation_project/screens/seller/seller_home_screen.dart';
import 'package:graduation_project/user_data/globalUserData.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum ECharacteres { user, seller }

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkBoxValue = false;
  final TextEditingController _password = TextEditingController();
  final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
  final TextEditingController _conEmail = TextEditingController();

  ECharacteres? _selectedOption = ECharacteres.user;

  String? _errorMessage;
  String? _emailError;
  String? _passwordError;

  //  void _login() {
  //   final persons = Provider.of<PersonProvider>(context, listen: false);
  //   if (_formKey.currentState!.validate()) {
  //     bool userExists = persons.persons.values.any((person) =>
  //         person.userName == _conEmail.text &&
  //         person.password == _password.text);
  //     if (userExists) {
  //       setState(() {
  //         _errorMessage = null; // Hide error message on successful login
  //       });
  //       PersonProvider personProvider =
  //           Provider.of<PersonProvider>(context, listen: false);
  //       PersonModule globalUserData =
  //           personProvider.getPersonDataUsingUserName(_conEmail.text);
  //       globalUser = GlobalUser(
  //           globalUserData.personId,
  //           globalUserData.name,
  //           globalUserData.userName,
  //           globalUserData.password,
  //           globalUserData.createdAt,
  //           globalUserData.address,
  //           globalUserData.emial,
  //           globalUserData.phoneNumber,
  //           false,
  //           '',
  //           '',
  //           '');
  //       // GlobalUser(globalUser.personId, globalUser.name, globalUser.userName,
  //       //     globalUser.password, globalUser.createdAt);
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const MainHomePage()),
  //       );
  //     } else {
  //       setState(() {
  //         _errorMessage = "Incorrect username or password!";
  //         _conEmailError =
  //             _conEmail.text.isEmpty ? "Please enter your user name" : null;
  //         _passwordError =
  //             _password.text.isEmpty ? "Please enter your password" : null;
  //       });
  //     }
  //   }
  // }

  // void _loginSeller() {
  //   final seller = Provider.of<SellersProvider>(context, listen: false);
  //   if (_formKey.currentState!.validate()) {
  //     bool userExists = seller.sellers.values.any((person) =>
  //         person.person.userName == _conEmail.text &&
  //         person.person.password == _password.text);
  //     if (userExists) {
  //       setState(() {
  //         _errorMessage = null; // Hide error message on successful login
  //       });
  //       SellersProvider sellerProvider =
  //           Provider.of<SellersProvider>(context, listen: false);
  //       Seller globalUserData =
  //           sellerProvider.getSellerDataUsingUserName(_conEmail.text);
  //       globalUser = GlobalUser(
  //           globalUserData.sellerID,
  //           globalUserData.person.name,
  //           globalUserData.person.userName,
  //           globalUserData.person.password,
  //           globalUserData.person.createdAt,
  //           globalUserData.person.address,
  //           globalUserData.person.emial,
  //           globalUserData.person.password,
  //           true,
  //           globalUserData.storeName,
  //           globalUserData.address,
  //           globalUserData.storeDescription);
  //       // GlobalUser(globalUser.personId, globalUser.name, globalUser.userName,
  //       //     globalUser.password, globalUser.createdAt);
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => SellerHomeScreen()),
  //       );
  //     } else {
  //       setState(() {
  //         _errorMessage = "Incorrect username or password!";
  //         _conEmailError =
  //             _conEmail.text.isEmpty ? "Please enter your user name" : null;
  //         _passwordError =
  //             _password.text.isEmpty ? "Please enter your password" : null;
  //       });
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _conEmail.addListener(_clearError);
    _password.addListener(_clearError);
  }

  @override
  void dispose() {
    _conEmail.removeListener(_clearError);
    _password.removeListener(_clearError);
    _conEmail.dispose();
    _password.dispose();
    super.dispose();
  }

  void _clearError() {
    setState(() {
      _errorMessage = null; // Clear error message when user starts typing
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 93, 146, 152),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 5),
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
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 50,
                          color: Color.fromARGB(255, 0, 104, 115),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextFormField(
                          controller: _password,
                          obscureText: true,
                          obscuringCharacter: '*',
                          onChanged: (value) {
                            _passwordError = _password.text.isEmpty
                                ? "Please enter your password"
                                : null;
                          },
                          decoration: InputDecoration(
                            errorText: _passwordError,
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, bottom: 5),
                        child: Row(
                          children: [
                            Checkbox(
                              value: checkBoxValue,
                              onChanged: (value) {
                                setState(() {
                                  checkBoxValue = value!;
                                });
                              },
                            ),
                            const Text("Remember me")
                          ],
                        ),
                      ),
                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Radio<ECharacteres>(
                      //             value: ECharacteres.user,
                      //             groupValue: _selectedOption,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 _selectedOption = value;
                      //               });
                      //             },
                      //           ),
                      //           const Text('User',
                      //               style: TextStyle(fontSize: 17)),
                      //         ],
                      //       ),
                      //       Row(
                      //         children: [
                      //           Radio<ECharacteres>(
                      //             value: ECharacteres.seller,
                      //             groupValue: _selectedOption,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 _selectedOption = value;
                      //               });
                      //             },
                      //           ),
                      //           const Text('Seller',
                      //               style: TextStyle(fontSize: 17)),
                      //         ],
                      //       ),
                      //     ]),
                      Consumer<LoginProvider>(
                          builder: (context, loginProvider, child) {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SizedBox(
                            width: 300,
                            height: 50,

                            /// that must be changed
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await loginProvider.login(
                                      _conEmail.text, _password.text);

                                  // Check if login is successful
                                  if (loginProvider.isAuthenticated) {
                                    // Navigate to another screen or show success message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Login successful!')),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               MainHomePage()),
                                    );
                                  } else {
                                    // Show an error message if login fails
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Login failed. Try again.')),
                                    );
                                  }
                                }
                              },
                              // onPressed: _selectedOption == ECharacteres.user
                              //     ? _login
                              //     : _loginSeller,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 3, 88, 98),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()),
                              );
                            },
                            child: const Text('Sign up'),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage()),
                          );
                        },
                        child: const Text('Forget Password'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



  // SharedPreferences? sharedPreferences;
  // String userName = "", password = "";

  // Future<String?> getName() async {
  //   String?  name = await sharedPreferences?.getString("name");
  //   if (name == null) return "";

  //   return name;
  // }

  // Future<String?> getPassword() async {
  //   if (sharedPreferences == null) return "";

  //   return sharedPreferences?.getString("password");
  // }

  // void loadData() async {
  //   String? fetchUserName = await getName();
  //   String? fetchPassword = await getPassword();

  //   setState(() {
  //     userName = fetchUserName!;
  //     password = fetchPassword!;
  //   });
  // }
