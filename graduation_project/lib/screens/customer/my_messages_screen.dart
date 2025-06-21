import 'package:flutter/material.dart';
import 'package:graduation_project/screens/customer/message_details_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/contact_provider.dart';
import '../../providers/login_provider.dart'; // Assuming you have a token in LoginProvider

class MyMessagesScreen extends StatefulWidget {
  const MyMessagesScreen({super.key});

  @override
  State<MyMessagesScreen> createState() => _MyMessagesScreenState();
}

class _MyMessagesScreenState extends State<MyMessagesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider =
          Provider.of<LoginProvider>(context, listen: false).token;
      await Provider.of<ContactProvider>(context, listen: false)
          .loadMessages(authProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text('My Messages', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 255, 242, 242),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Builder(
        builder: (_) {
          if (contactProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (contactProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 40),
                  const SizedBox(height: 12),
                  Text('Error: ${contactProvider.error}',
                      style: const TextStyle(color: Colors.red)),
                ],
              ),
            );
          } else if (contactProvider.messages.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mail_outline, color: Colors.grey, size: 60),
                  SizedBox(height: 12),
                  Text('No messages found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            itemCount: contactProvider.messages.length,
            itemBuilder: (context, index) {
              final message = contactProvider.messages[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MessageDetailScreen(messageId: message.messageId),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          message.hasReply
                              ? Icons.mark_email_read
                              : Icons.mark_email_unread,
                          color:
                              message.hasReply ? Colors.green : Colors.orange,
                          size: 28,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.subject,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Sent at: ${message.sentAt}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
