import 'package:flutter/material.dart';
import 'package:graduation_project/providers/admin_message_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/login_provider.dart';

class AdminMessageDetailScreen extends StatefulWidget {
  final int messageId;

  const AdminMessageDetailScreen({super.key, required this.messageId});

  @override
  State<AdminMessageDetailScreen> createState() =>
      _AdminMessageDetailScreenState();
}

class _AdminMessageDetailScreenState extends State<AdminMessageDetailScreen> {
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Provider.of<LoginProvider>(context, listen: false).token;
      Provider.of<AdminMessageProvider>(context, listen: false)
          .fetchDetail(token ?? '', widget.messageId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminMessageProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Message Detail')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(
                  child: Text('Error: ${provider.error}',
                      style: const TextStyle(color: Colors.red)))
              : provider.detail == null
                  ? const Center(child: Text('No message found.'))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 5)
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Subject: ${provider.detail!.subject}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text('Sent at: ${provider.detail!.sentAt}',
                                    style: const TextStyle(color: Colors.grey)),
                                const Divider(height: 30),
                                const Text('User Message',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                const SizedBox(height: 6),
                                Text(provider.detail!.message),
                                const Divider(height: 30),
                                const Text('Admin Reply',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                const SizedBox(height: 6),
                                Text(provider.detail!.adminReply),
                                if (provider.detail!.repliedAt != "---")
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                        'Replied at: ${provider.detail!.repliedAt}',
                                        style: const TextStyle(
                                            color: Colors.green)),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (provider.detail!.adminReply ==
                              "No Response until now") ...[
                            TextField(
                              controller: _replyController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: 'Enter your reply...',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: () async {
                                final reply = _replyController.text.trim();
                                if (reply.isEmpty) return;

                                final token = Provider.of<LoginProvider>(
                                        context,
                                        listen: false)
                                    .token;
                                await provider.sendReply(
                                    token!, widget.messageId, reply);
                                _replyController.clear();
                              },
                              icon: const Icon(Icons.send, color: Colors.white,),
                              label: const Text("Send Reply", style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 135, 35, 35),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
    );
  }
}
