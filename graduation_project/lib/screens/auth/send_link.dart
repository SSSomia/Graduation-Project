import 'package:flutter/material.dart';
import 'package:graduation_project/screens/auth/login_page.dart';

class ResetLinkSentPage extends StatelessWidget {
  final String email;

  const ResetLinkSentPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Your Email'),
        backgroundColor: const Color(0xFF035862),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mark_email_read_outlined,
                  size: 80, color: Colors.teal),
              const SizedBox(height: 20),
              Text(
                'We’ve sent a password reset link to:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 10),
              Text(
                email,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  // Optionally: open email app or return to login
                  //Navigator.pop(context);
                  // Return to login or previous page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LoginPage()
                    ),
                  );
                },
                icon: const Icon(Icons.login),
                label: const Text('Back to Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF035862),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
