import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

enum SingingCharacter { lafayette, jefferson }

class _SignupPageState extends State<SignupPage> {
  String? _selectedOption = "Option 1";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 205, 252, 232),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 600,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 246, 254, 249)
                            .withOpacity(0.5), // shadow color with opacity
                        spreadRadius: 5, // extent of shadow spreading
                        blurRadius: 10, // blurring amount
                        offset: const Offset(
                            0, 5), // horizontal and vertical shadow offset
                      ),
                    ],
                    gradient: const RadialGradient(
                      center: Alignment(1, 1),
                      radius: 0.50,
                      colors: <Color>[
                        Color.fromARGB(255, 255, 251, 251),
                        Color.fromARGB(255, 147, 255, 215),
                      ],
                      stops: <double>[0.9, 1.0],
                    ),
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
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              labelText: 'username',
                              prefixIcon: const Icon(Icons.person_2_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set the radius for rounded corners
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              labelText: 'password',
                              suffix: const Icon(Icons.remove_red_eye),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set the radius for rounded corners
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              labelText: 'confirm password',
                              suffix: const Icon(Icons.remove_red_eye),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set the radius for rounded corners
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // SizedBox(
                        //   height: 50,
                        //   width: 50,
                        //   child: Row(children: [
                        //     RadioListTile<String>(
                        //       title: const Text("Option 1"),
                        //       value: "Option 1",
                        //       groupValue: _selectedOption,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           _selectedOption = value;
                        //         });
                        //       },
                        //     ),
                        //     RadioListTile<String>(
                        //       title: const Text("Option 2"),
                        //       value: "Option 2",
                        //       groupValue: _selectedOption,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           _selectedOption = value;
                        //         });
                        //       },
                        //     ),
                        //   ]),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   Navigator.of(context).pushNamed('homePage');
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 255,
                                    255, 255), // Background color of the button
                                foregroundColor: const Color.fromARGB(
                                    255,
                                    84,
                                    180,
                                    154), // Text (foreground) color of the button
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
