import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graduation_project/api_providers/forget_passwrod_provider.dart';
import 'package:graduation_project/screens/auth/reset_pawword_page.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 116, 180, 187),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_reset_rounded,
                  size: 80, color: Colors.teal),
              const SizedBox(height: 20),
              const Text(
                'Enter your email address to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              Consumer<ForgetPasswrodProvider>(
                  builder: (context, forgetPasswrodProvider, child) {
                return ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final email = _emailController.text;
                      // You can now send the email to your backend to handle password reset
                      await forgetPasswrodProvider.forgetPassword(email);
                      if (forgetPasswrodProvider.isAuthenticated) {
                        // Navigate to another screen or show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('email is exist!')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordPage(
                                email: email,
                                token: forgetPasswrodProvider.token),
                          ),
                        );
                      } else {
                        // Show an error message if login fails
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('email not found. Try again.')));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    backgroundColor: const Color(0xFF035862),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
