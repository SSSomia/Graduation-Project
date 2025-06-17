import 'package:flutter/material.dart';
import 'package:graduation_project/providers/track_order_provider.dart';
import 'package:provider/provider.dart';

class TrackOrderPage extends StatefulWidget {
  final int orderId;
  final String token;

  const TrackOrderPage({Key? key, required this.orderId, required this.token})
      : super(key: key);

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TrackingProvider>(context, listen: false)
          .loadTracking(widget.orderId, widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        }

        final data = provider.trackingData;

        if (data == null) {
          return const Center(child: Text('No tracking data.'));
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Current status with color tag
                  Row(
                    children: [
                      const Icon(Icons.local_shipping, color: Colors.teal),
                      const SizedBox(width: 8),
                      Text(
                        "Current Status: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      Chip(
                        label: Text(data.currentStatus),
                        backgroundColor: Colors.teal.shade100,
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// History section
                  const Text("Tracking History",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  const Divider(),

                  // Use Flexible ListView to avoid overflow
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.trackingHistory.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = data.trackingHistory[index];
                      return ListTile(
                        leading: const Icon(Icons.check_circle_outline, color: Colors.teal),
                        title: Text(item.status),
                        subtitle: Text("Updated at: ${item.changedAt}"),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
