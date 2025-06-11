import 'package:flutter/material.dart';
import 'package:graduation_project/models/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationDetailScreen extends StatelessWidget {
  final AppNotification notification;

  const NotificationDetailScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 12),
            Text(
              DateFormat('yMMMMd – h:mm a').format(notification.createdAt),
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(height: 32),
            Text(
              notification.message,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
