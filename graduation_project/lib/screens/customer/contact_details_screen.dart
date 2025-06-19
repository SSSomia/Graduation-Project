import 'package:flutter/material.dart';
import 'package:graduation_project/providers/contact_details_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/login_provider.dart';

class ContactMessageDetailScreen extends StatefulWidget {
  final int messageId;

  const ContactMessageDetailScreen({super.key, required this.messageId});

  @override
  State<ContactMessageDetailScreen> createState() =>
      _ContactMessageDetailScreenState();
}

class _ContactMessageDetailScreenState
    extends State<ContactMessageDetailScreen> {
  @override
  void initState() {
    super.initState();
    final token = Provider.of<LoginProvider>(context, listen: false).token;
    Provider.of<ContactDetailProvider>(context, listen: false)
        .fetchMessageDetails(token, widget.messageId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactDetailProvider>(context);
    final detail = provider.messageDetail;

    return Scaffold(
      appBar: AppBar(title: const Text('Message Details')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(child: Text(provider.error!))
              : detail == null
                  ? const Center(child: Text('No details found.'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRow('Subject:', detail.subject),
                              const SizedBox(height: 12),
                              _buildRow('Message:', detail.message),
                              const SizedBox(height: 12),
                              _buildRow('Sent At:', detail.sentAt),
                              const SizedBox(height: 12),
                              _buildRow('Replied At:', detail.repliedAt),
                              const SizedBox(height: 12),
                              _buildRow('Admin Reply:', detail.adminReply),
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 15)),
      ],
    );
  }
}
