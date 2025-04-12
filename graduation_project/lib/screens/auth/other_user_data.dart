import 'package:flutter/material.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:graduation_project/screens/auth/seller_market_data.dart';
import 'package:graduation_project/models/person_module.dart';
import 'package:graduation_project/providers/person_provider.dart';
import 'package:provider/provider.dart';

class OtherUserData extends StatefulWidget {
  String userName;
  String name;
  String password;
  DateTime createdAt;
  OtherUserData(
      {super.key,
      required this.name,
      required this.userName,
      required this.password,
      required this.createdAt});

  @override
  State<OtherUserData> createState() => _OtherUserDataState();
}

enum ECharacteres { user, seller }

class _OtherUserDataState extends State<OtherUserData> {
  final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
  final RegExp phoneRegExp = RegExp(r'^(010|011|012|015)[0-9]{8}$');
  late String personID = '';
  late PersonModule person;

  final _formKey = GlobalKey<FormState>();
  ECharacteres? _selectedOption = ECharacteres.user;

  String? _phoneNumberError;
  String? _emailError;
  String? _addressError;

  final TextEditingController _conPhoneNumber = TextEditingController();
  final TextEditingController _conEmail = TextEditingController();
  final TextEditingController _conaddress = TextEditingController();

  @override
  void dispose() {
    _conEmail.dispose();
    _conPhoneNumber.dispose();
    _conaddress.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _emailError = _conEmail.text.isEmpty ? "Please enter your email" : null;
      _phoneNumberError = _conPhoneNumber.text.isEmpty
          ? "Please enter your phone number"
          : null;
      _addressError =
          _conaddress.text.isEmpty ? "Please enter your address" : null;
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
                    height: 550,
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
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 0, bottom: 10),
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
                                controller: _conPhoneNumber,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a phone number";
                                  } else if (!phoneRegExp.hasMatch(value)) {
                                    return "Phone number isn't true";
                                  }
                                },
                                // obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Phone number',
                                  prefixIcon:
                                      const Icon(Icons.phone_android_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  errorText: _phoneNumberError,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _phoneNumberError = value.isEmpty
                                        ? "Please enter your phone number"
                                        : null;
                                  });
                                },
                              )),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 10, bottom: 10),
                            child: TextFormField(
                              controller: _conaddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your address";
                                }
                              },
                              //  obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Address',
                                prefixIcon: const Icon(Icons.home_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorText: _addressError,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _addressError = value.isEmpty
                                      ? "Please enter your address"
                                      : null;
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
                          MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: SizedBox(
                                  width: 300,
                                  height: 50,
                                  child: Consumer<PersonProvider>(
                                      builder: (context, personList, child) {
                                        personID = personList.numberOfPersons.toString();
                                        person = PersonModule(
                                                personID,
                                                widget.userName,
                                                widget.name,
                                                widget.password,
                                                widget.createdAt,
                                                _conaddress.text,
                                                _conEmail.text,
                                                _conPhoneNumber.text,
                                              );
                                    return ElevatedButton(
                                        onPressed: () {
                                          // _validateForm();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (_selectedOption ==
                                                ECharacteres.user) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage()));
                                              personList.addPerson(person);
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                           SellerMarketData(person: person,)));
                                            }
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
                                        child: _selectedOption == ECharacteres.user? const Text("Sign Up"): const Text(
                                          '------>',
                                          style: TextStyle(fontSize: 20),
                                        ));
                                  }))),
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
