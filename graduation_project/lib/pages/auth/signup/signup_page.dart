import 'package:flutter/material.dart';
import 'package:graduation_project/pages/constant.dart';
import 'package:graduation_project/pages/auth/login/login_page.dart';
import 'package:graduation_project/pages/profile/person_module.dart';
import 'package:graduation_project/pages/profile/person_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

enum ECharacteres { user, seller }

class _SignupPageState extends State<SignupPage> {
  ECharacteres? _selectedOption = ECharacteres.user;

  final TextEditingController _conFirstName = TextEditingController();
  final TextEditingController _conLastName = TextEditingController();
  final TextEditingController _conUserName = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();
  final TextEditingController _conConfirmPassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    // Dispose the controller when the widget is removed
    _conFirstName.dispose();
    _conConfirmPassword.dispose();
    _conLastName.dispose();
    _conLastName.dispose();
    _conUserName.dispose();
    _conPassword.dispose();
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
                              .withOpacity(0.5), // shadow color with opacity
                          spreadRadius: 5, // extent of shadow spreading
                          blurRadius: 10, // blurring amount
                          offset: const Offset(
                              0, 5), // horizontal and vertical shadow offset
                        ),
                      ],
                    ),
                    child: Form(
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
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          labelText: 'first name',
                                          prefixIcon: const Icon(
                                              Icons.person_2_outlined),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
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
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          labelText: 'last name',
                                          prefixIcon: const Icon(
                                              Icons.person_2_outlined),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 10, bottom: 10),
                            child: TextFormField(
                              controller: _conUserName,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                labelText: 'username',
                                prefixIcon: const Icon(Icons.person_2_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 20, bottom: 10),
                            child: TextFormField(
                              controller: _conPassword,
                              obscureText: true,
                              obscuringCharacter: '*',
                              decoration: InputDecoration(
                                  labelText: 'password',
                                  prefix:
                                      const Icon(Icons.lock_outline_rounded),
                                  suffix: const Icon(Icons.remove_red_eye),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 20, bottom: 10),
                            child: TextFormField(
                              controller: _conConfirmPassword,
                              obscureText: true,
                              obscuringCharacter: '*',
                              decoration: InputDecoration(
                                labelText: 'confirm password',
                                prefix: const Icon(Icons.lock_outline_rounded),
                                suffix: const Icon(Icons.remove_red_eye),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
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
                                          personList.addPerson(PersonModule(
                                              personList.numberOfPersons
                                                  .toString(),
                                              _conUserName.text,
                                              _conFirstName.text +
                                                  _conLastName.text,
                                              _conPassword.text,
                                              DateTime.now()));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage()));

                                          // if (_formKey.currentState!.validate()) {
                                          //   Navigator.of(context).pushNamed('homePage');
                                          // }
                                          // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                          // sharedPreferences.setString("userName", "")
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
