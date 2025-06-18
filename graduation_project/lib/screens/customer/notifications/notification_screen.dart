import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/notification_provider.dart';
import 'package:graduation_project/screens/customer/notifications/notification_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = Provider.of<LoginProvider>(context, listen: false).token;
      final notifProvider =
          Provider.of<NotificationProvider>(context, listen: false);

      await notifProvider.fetchNotifications(token);
      // await notifProvider.fetchUnreadCount(token);
    });
    super.initState();
   // _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    final token = Provider.of<LoginProvider>(context, listen: false).token;
    final notifProvider =
        Provider.of<NotificationProvider>(context, listen: false);

    await notifProvider.fetchNotifications(token);
    await notifProvider.fetchUnreadCount(token);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context);
    final notifications = provider.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
              ? const Center(child: Text('No notifications available.'))
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final notif = notifications[index];
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
                        tileColor:
                            notif.isRead ? Colors.grey[100] : Colors.white,
                        leading: Icon(
                          Icons.notifications,
                          color: notif.isRead ? Colors.grey : Colors.blue,
                        ),
                        title: Text(
                          notif.title,
                          style: TextStyle(
                            fontWeight: notif.isRead
                                ? FontWeight.normal
                                : FontWeight.bold,
                            color: notif.isRead ? Colors.black54 : Colors.black,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notif.message,
                              style: TextStyle(
                                color: notif.isRead
                                    ? Colors.black54
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('yMMMd – hh:mm a')
                                  .format(notif.createdAt),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () async {
                          final token =
                              Provider.of<LoginProvider>(context, listen: false)
                                  .token;

                          // Wait for the next frame before doing state-changing logic
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) async {
                            await provider.markNotificationAsRead(
                                token, notif.id);

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NotificationDetailScreen(
                                    notification: notif),
                              ),
                            );

                            await provider.fetchUnreadCount(token);
                          });
                        },
                      ),
                      // child: ListTile(
                    );
                  },
                ),
    );
  }
}

                      //   contentPadding: const EdgeInsets.symmetric(
                      //     vertical: 10,
                      //     horizontal: 16,
                      //   ),
                      //   leading:
                      //       const Icon(Icons.notifications, color: Colors.blue),
                      //   title: Text(
                      //     notif.title,
                      //     style: const TextStyle(fontWeight: FontWeight.bold),
                      //   ),
                      //   subtitle: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(notif.message),
                      //       const SizedBox(height: 4),
                      //       Text(
                      //         DateFormat('yMMMd – hh:mm a')
                      //             .format(notif.createdAt),
                      //         style: const TextStyle(
                      //             fontSize: 12, color: Colors.grey),
                      //       ),
                      //     ],
                      //   ),
                      //   onTap: () async {
                      //     final token =
                      //         Provider.of<LoginProvider>(context, listen: false)
                      //             .token;

                      //     await provider.markNotificationAsRead(
                      //         token, notif.id);

                      //     // Navigate to detail
                      //     await Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (_) => NotificationDetailScreen(
                      //           notification: notif,
                      //         ),
                      //       ),
                      //     );

                      //     // Refetch unread count, but DO NOT reload the entire list
                      //     await provider.fetchUnreadCount(token);
                      //     // Optional: if you want to refresh the list only if needed
                      //     // await _fetchData();
                      //   },
                      // ),