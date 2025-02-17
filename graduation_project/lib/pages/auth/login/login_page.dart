import 'package:flutter/material.dart';
import 'package:graduation_project/pages/home/home_page.dart';
import 'package:graduation_project/pages/main_page/mainPage.dart';
import 'package:graduation_project/pages/auth/signup/signup_page.dart';
import 'package:graduation_project/pages/profile/person_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkBoxValue = false;
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
                // color: Colors.white,
                width: 350,
                height: 450,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 109, 109, 109)
                            .withOpacity(0.5), // shadow color with opacity
                        spreadRadius: 5, // extent of shadow spreading
                        blurRadius: 10, // blurring amount
                        offset: const Offset(
                            0, 5), // horizontal and vertical shadow offset
                      ),
                    ]),
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
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: TextFormField(
                          controller: _userName,
                          // initialValue: userName,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelText: 'username',
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the radius for rounded corners
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else if (value != _userName) {
                              return 'user name not correct';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        child: TextFormField(
                          //  initialValue: password,
                          controller: _password,
                          obscureText: true,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            labelText: 'enter your password',
                            prefix: const Icon(Icons.password_outlined),
                            suffix: const Icon(Icons.remove_red_eye),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the radius for rounded corners
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else if (value != _password) {
                              return 'password not correct';
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
                                onChanged: (value) async {
                                  setState(() {
                                    checkBoxValue = value!;
                                  });
                                }),
                            const Text("Remember me")
                          ],
                        ),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              final persons = Provider.of<PersonProvider>(
                                  context,
                                  listen: false);
                              if (persons.persons.values.any((person) =>
                                      person.userName == _userName.text) &&
                                  persons.persons.values.any((person) =>
                                      person.password == _password.text)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainHomePage()));
                              }
                              // if (checkBoxValue) {
                              //   SharedPreferences sharedPreferences =
                              //       await SharedPreferences.getInstance();
                              //   sharedPreferences.setString(
                              //       "name", _userName.text);
                              //   sharedPreferences.setString(
                              //       "password", _password.text);
                              // }

                              // if (_formKey.currentState!.validate()) {
                              //   Navigator.of(context).pushNamed('homePage');
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 3, 88, 98),
                              foregroundColor: const Color.fromARGB(
                                  255,
                                  255,
                                  255,
                                  255), // Text (foreground) color of the button
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignupPage()),
                                );
                              },
                              child: const Text('Sign up'))
                        ],
                      )
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
