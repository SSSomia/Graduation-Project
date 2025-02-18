import 'package:flutter/material.dart';
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

  String? _errorMessage;
  String? _userNameError;
  String? _passwordError;

  void _login() {
    final persons = Provider.of<PersonProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      bool userExists = persons.persons.values.any((person) =>
          person.userName == _userName.text &&
          person.password == _password.text);

      if (userExists) {
        setState(() {
          _errorMessage = null; // Hide error message on successful login
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainHomePage()),
        );
      } else {
        setState(() {
          _errorMessage = "Incorrect username or password!";
          _userNameError =
              _userName.text.isEmpty ? "Please enter your user name" : null;
          _passwordError =
              _password.text.isEmpty ? "Please enter your password" : null;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _userName.addListener(_clearError);
    _password.addListener(_clearError);
  }

  @override
  void dispose() {
    _userName.removeListener(_clearError);
    _password.removeListener(_clearError);
    _userName.dispose();
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextFormField(
                          controller: _userName,
                          onChanged: (value) {
                            setState(() {
                              _userNameError = _userName.text.isEmpty
                                  ? "Please enter your user name"
                                  : null;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                            errorText: _userNameError,
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
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
                            labelText: 'Enter your password',
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
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _login,
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
                            child: const Text('Sign up'),
                          ),
                        ],
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
