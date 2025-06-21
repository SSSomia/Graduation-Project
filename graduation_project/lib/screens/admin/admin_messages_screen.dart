import 'package:flutter/material.dart';
import 'package:graduation_project/screens/admin/admin_message_details_screen.dart';
import 'package:graduation_project/screens/customer/message_details_screen.dart';
import 'package:provider/provider.dart';
import '../../models/admin_message_model.dart';
import '../../providers/admin_message_provider.dart';
import '../../providers/login_provider.dart';

class AdminMessagesScreen extends StatefulWidget {
  const AdminMessagesScreen({super.key});

  @override
  State<AdminMessagesScreen> createState() => _AdminMessagesScreenState();
}

class _AdminMessagesScreenState extends State<AdminMessagesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Provider.of<LoginProvider>(context, listen: false).token;
      Provider.of<AdminMessageProvider>(context, listen: false)
          .loadAdminMessages(token ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminMessageProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Messages')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(child: Text('Error: ${provider.error}'))
              : ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    const Text('Unread Messages',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    ...provider.unreadMessages.map((msg) =>
                        _buildMessageCard(context, msg, isRead: false)),
                    const SizedBox(height: 16),
                    const Text('Read Messages',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    ...provider.readMessages.map(
                        (msg) => _buildMessageCard(context, msg, isRead: true)),
                  ],
                ),
    );
  }

  Widget _buildMessageCard(BuildContext context, AdminMessage msg,
      {required bool isRead}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: Icon(
          isRead ? Icons.mark_email_read : Icons.mark_email_unread,
          color: isRead ? Colors.green : Colors.orange,
        ),
        title: Text(msg.subject),
        subtitle: Text('Sent: ${msg.sentAtDateTime.split('T')[0]}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AdminMessageDetailScreen(messageId: msg.messageId),
            ),
          );
        },
      ),
    );
  }
}
