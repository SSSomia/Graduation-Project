import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/function/getUserRoleFromTokenFunction.dart';
import 'package:graduation_project/screens/admin/admin_management_page.dart';
import 'package:graduation_project/screens/auth/forget_pawword.dart';
import 'package:graduation_project/screens/customer/mainPage.dart';
import 'package:graduation_project/screens/auth/signup_page.dart';
import 'package:graduation_project/screens/seller/seller/seller_home_screen.dart';
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


  String? _errorMessage;
  String? _emailError;
  String? _passwordError;

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
                            }
                            // } else if (!emailRegExp.hasMatch(value)) {
                            //   return "Please enter a valid email";
                            // }
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
                                    final role = getUserRoleFromToken(
                                        loginProvider.token);
                                    if (role == "seller") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SellerHomeScreen()),
                                      );
                                    } else if (role == "user") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainHomePage()),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminManagementPage()),
                                      );
                                    }
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
