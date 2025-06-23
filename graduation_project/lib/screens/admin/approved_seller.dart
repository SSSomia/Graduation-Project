import 'package:flutter/material.dart';
import 'package:graduation_project/models/pending_seller.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/pending_seller_provider.dart';
import 'package:graduation_project/widgets/adminDrawer.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/screens/auth/login_page.dart';

class ApprovedSellers extends StatefulWidget {
  @override
  _ApprovedSellersState createState() => _ApprovedSellersState();
}

class _ApprovedSellersState extends State<ApprovedSellers> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);

      // Load sellers on init
      Provider.of<AdminProvider>(context, listen: false)
          .loadApprovedSellers(authProvider.token);
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
                  radius: 40,child: Icon(Icons.store,size: 40, color: Color.fromARGB(255, 158, 23, 23),),backgroundColor: Color.fromARGB(255, 255, 229, 227),),
              const SizedBox(height: 10),
              Text("Name: ${request.firstName} ${request.lastName}",
                  style: const TextStyle(fontSize: 16)),
              Text("Description: ${request.storeDescription}",
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProvider>(context);
    final requests = provider.approvedSeller;

    return Scaffold(
            // endDrawer: Admindrawer(),

      appBar: AppBar(
        title: const Text(
          'Approved Sellers',
         
        ),
        // leading: const Icon(Icons.shopping_bag_outlined),
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
                : provider.approvedSeller.isEmpty
                    ? const Center(child: Text("No Approved Sellers!!"))
                    : ListView.builder(
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final request = requests[index];
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading:
                                  const CircleAvatar(child: Icon(Icons.store, color: Color.fromARGB(255, 158, 23, 23),),backgroundColor: Color.fromARGB(255, 255, 229, 227),),
                              title: Text(request.storeName),
                              subtitle: Text(request.storeDescription),
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
