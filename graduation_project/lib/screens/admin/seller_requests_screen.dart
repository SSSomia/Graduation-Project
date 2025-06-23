import 'package:flutter/material.dart';
import 'package:graduation_project/models/pending_seller.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/pending_seller_provider.dart';
import 'package:graduation_project/widgets/adminDrawer.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/screens/auth/login_page.dart';

class SellerRequestsPage extends StatefulWidget {
  @override
  _SellerRequestsPageState createState() => _SellerRequestsPageState();
}

class _SellerRequestsPageState extends State<SellerRequestsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);

      // Load sellers on init
      Provider.of<AdminProvider>(context, listen: false)
          .loadPendingSellers(authProvider.token);
    });
  }

  void showSellerDetailsDialog(BuildContext context, PendingSeller request) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(request.storeName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                  radius: 40, child: Icon(Icons.store, size: 40)),
              const SizedBox(height: 10),
              Text("Name: ${request.firstName} ${request.lastName}",
                  style: const TextStyle(fontSize: 16)),
              Text("Description: ${request.storeDescription}",
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Text(
                "Status: ${request.status.toUpperCase()}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: request.status == 'accepted'
                      ? Colors.green
                      : request.status == 'rejected'
                          ? Colors.red
                          : const Color.fromARGB(255, 122, 29, 23),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProvider>(context);
    final requests = provider.pendingSellers;

    return Scaffold(
      endDrawer: Admindrawer(),
      appBar: AppBar(
        title: const Text(
          'Seller Requests',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.shopping_bag_outlined),
        backgroundColor: const Color.fromARGB(255, 255, 250, 250),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.pendingSellers.isEmpty
                    ? Center(child: Text("No Pending Sellers!!"))
                    : ListView.builder(
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final request = requests[index];
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading:
                                  const CircleAvatar(child: Icon(Icons.store)),
                              title: Text(request.storeName),
                              subtitle: Text(request.storeDescription),
                              trailing: request.status == 'pending'
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.check,
                                              color: Color.fromARGB(
                                                  255, 36, 146, 135)),
                                          onPressed: () async {
                                            final authProvider =
                                                Provider.of<LoginProvider>(
                                                    context,
                                                    listen: false);
                                            await provider.approveSeller(
                                                userId: request.userId,
                                                token: authProvider.token);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Color.fromARGB(
                                                  255, 146, 46, 39)),
                                          onPressed: () async {
                                            final authProvider =
                                                Provider.of<LoginProvider>(
                                                    context,
                                                    listen: false);
                                            await provider.rejectSeller(
                                                sellerId: request.userId,
                                                token: authProvider.token);
                                          },
                                        ),
                                      ],
                                    )
                                  : Text(
                                      request.status.toUpperCase(),
                                      style: TextStyle(
                                        color: request.status == "accepted"
                                            ? const Color.fromARGB(
                                                255, 35, 137, 146)
                                            : const Color.fromARGB(
                                                255, 116, 19, 12),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              onTap: () =>
                                  showSellerDetailsDialog(context, request),
                            ),
                          );
                        },
                      ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(builder: (context) => const LoginPage()),
          //         (route) => false,
          //       );
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: const Color.fromARGB(255, 204, 45, 45),
          //       padding:
          //           const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //     ),
          //     child: const Text(
          //       'Logout',
          //       style: TextStyle(fontSize: 18, color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
