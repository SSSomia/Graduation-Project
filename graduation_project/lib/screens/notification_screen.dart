import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/notification_provider.dart';
import 'package:graduation_project/screens/notification_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context);
    final loginToken = Provider.of<LoginProvider>(context, listen: false);

    final String token = loginToken.token;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              provider.fetchNotifications(token);
              provider.fetchUnreadCount(token);
            },
          ),
        ],
      ),
      body: provider.notifications.isEmpty
          ? const Center(child: Text('No notifications available.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: provider.notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final notif = provider.notifications[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    leading:
                        const Icon(Icons.notifications, color: Colors.blue),
                    title: Text(
                      notif.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notif.message),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('yMMMd – hh:mm a').format(notif.createdAt),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    onTap: () async {
                      await provider.markNotificationAsRead(token, notif.id);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              NotificationDetailScreen(notification: notif),
                        ),
                      );
                      // Optional: mark as read or navigate
                    },
                  ),
                );
              },
            ),
    );
  }
}
