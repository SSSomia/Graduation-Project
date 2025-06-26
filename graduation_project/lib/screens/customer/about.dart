import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = const Color.fromARGB(255, 158, 107, 107);

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/logo/bag.png'),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Spark Up',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Version 1.0.0',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              'Spark Up is your one-stop destination for online shopping.\n\n'
                              'We bring the latest trends and products at unbeatable prices. '
                              'Enjoy fast delivery, secure payment, and excellent customer service.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Divider(),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.email_rounded,
                                        color: Colors.blue),
                                    SizedBox(width: 10),
                                    Text('support@sparkup.com'),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Icon(Icons.phone_rounded,
                                        color: Colors.green),
                                    SizedBox(width: 10),
                                    Text('01276497020'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(), // pushes copyright
                        const SizedBox(height: 30),
                        const Text(
                          '© 2025 ShopEase Inc. All rights reserved.',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
