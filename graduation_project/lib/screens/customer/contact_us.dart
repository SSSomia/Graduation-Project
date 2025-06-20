import 'package:flutter/material.dart';
import 'package:graduation_project/providers/contact_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:provider/provider.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

void _sendMessage() async {
  if (_formKey.currentState!.validate()) {
    final token = Provider.of<LoginProvider>(context, listen: false).token;
    final contactProvider = Provider.of<ContactProvider>(context, listen: false);

    final subject = _emailController.text.trim();
    final message = _messageController.text.trim();

    await contactProvider.sendMessage(token, subject, message);

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Thank You!"),
          content: Text(contactProvider.responseMessage ?? "Your message has been sent."),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    }

    _emailController.clear();
    _messageController.clear();
  }
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const colorScheme = Color.fromARGB(255, 107, 158, 157);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.withOpacity(0.05),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.headset_mic_rounded,
                  size: 80, color: Color.fromARGB(255, 49, 156, 156)),
              const SizedBox(height: 10),
              const Text(
                'We’d Love to Hear from You',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Fill out the form and we’ll get back to you.',
                style: TextStyle(color: Color.fromARGB(255, 117, 117, 117)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Form Card
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'subject',
                            prefixIcon: const Icon(Icons.subject_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter the subject' : null,
                        ),
                        const SizedBox(height: 16),

                        // Message Field
                        TextFormField(
                          controller: _messageController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            prefixIcon: const Icon(Icons.message),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your message'
                              : null,
                        ),
                        const SizedBox(height: 24),

                        // Send Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _sendMessage,
                            icon: const Icon(
                              Icons.send_rounded,
                              color: Color.fromARGB(255, 42, 130, 133),
                            ),
                            label: const Text(
                              'Send Message',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Extra Contact Info (Optional)
              const Column(
                children: [
                  Text(
                    'Need urgent help?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text('01276497020'),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text('support@shopy.com'),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
