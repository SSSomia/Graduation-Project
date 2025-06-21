import 'package:flutter/material.dart';
import 'package:graduation_project/providers/contact_details_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/login_provider.dart';

class MessageDetailScreen extends StatefulWidget {
  final int messageId;

  const MessageDetailScreen({super.key, required this.messageId});

  @override
  State<MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = Provider.of<LoginProvider>(context, listen: false).token;
      await Provider.of<ContactDetailProvider>(context, listen: false)
          .fetchMessageDetails(token, widget.messageId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Message Details'), backgroundColor: const Color.fromARGB(255, 242, 242, 242),),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(child: Text('Error: ${provider.error}'))
              : provider.messageDetail == null
                  ? const Center(child: Text('No data found.'))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.subject, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      provider.messageDetail!.subject,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.send, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Sent at: ${provider.messageDetail!.sentAt}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Divider(height: 30),
                              const Text(
                                'Message',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 6),
                              SelectableText(
                                provider.messageDetail!.message,
                                style: const TextStyle(fontSize: 15),
                              ),
                              const Divider(height: 30),
                              const Text(
                                'Admin Reply',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 6),
                              provider.messageDetail!.adminReply != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectableText(
                                          provider.messageDetail!.adminReply!,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(Icons.reply,
                                                color: Colors.green),
                                            const SizedBox(width: 6),
                                            Text(
                                              'Replied at: ${provider.messageDetail!.repliedAt ?? ''}',
                                              style: const TextStyle(
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : const Text(
                                      'No reply yet.',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }
}
