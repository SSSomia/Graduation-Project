import 'package:flutter/material.dart';
import 'package:graduation_project/screens/auth/login_page.dart';

class SellerRequestsPage extends StatefulWidget {
  @override
  _SellerRequestsPageState createState() => _SellerRequestsPageState();
}

class _SellerRequestsPageState extends State<SellerRequestsPage> {
  List<Map<String, dynamic>> sellerRequests = [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "store": "John's Shop",
      "logo": null, // Replace with image URL if available
      "status": "pending"
    },
    {
      "id": 2,
      "name": "Jane Smith",
      "email": "jane@example.com",
      "store": "Jane's Boutique",
      "logo": null,
      "status": "pending"
    },
  ];

  void updateRequestStatus(int id, String status) {
    setState(() {
      sellerRequests = sellerRequests.map((request) {
        if (request['id'] == id) {
          return {...request, "status": status};
        }
        return request;
      }).toList();
    });

    // Here you would send an API request to update the status on the backend
  }

  void showSellerDetailsDialog(
      BuildContext context, Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(request['store']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              request['logo'] != null
                  ? CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(request['logo']))
                  : const CircleAvatar(
                      radius: 40, child: Icon(Icons.store, size: 40)),
              const SizedBox(height: 10),
              Text("Name: ${request['name']}",
                  style: const TextStyle(fontSize: 16)),
              Text("Email: ${request['email']}",
                  style: const TextStyle(fontSize: 16)),
              Text("Description: ${request['description']}",
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              if (request['status'] == "pending")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Accept",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 36, 134, 134)),
                      onPressed: () {
                        updateRequestStatus(request['id'], "accepted");
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Reject",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 116, 33, 27)),
                      onPressed: () {
                        updateRequestStatus(request['id'], "rejected");
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              else
                Text(
                  "Status: ${request['status'].toUpperCase()}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: request['status'] == "accepted"
                          ? const Color.fromARGB(255, 23, 133, 103)
                          : const Color.fromARGB(255, 122, 29, 23)),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Seller Requestes',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const Icon(Icons.shopping_bag_outlined),
          backgroundColor: const Color.fromARGB(255, 244, 255, 254),
          //  shadowColor: const Color.fromARGB(255, 252, 252, 252),
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
              child: ListView.builder(
                itemCount: sellerRequests.length,
                itemBuilder: (context, index) {
                  final request = sellerRequests[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: request['logo'] != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(request['logo']))
                          : const CircleAvatar(child: Icon(Icons.store)),
                      title: Text(request['store']),
                      subtitle: Text("${request['name']} - ${request['email']}"),
                      trailing: request['status'] == "pending"
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.check,
                                      color: Color.fromARGB(255, 36, 146, 135)),
                                  onPressed: () => updateRequestStatus(
                                      request['id'], "accepted"),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Color.fromARGB(255, 146, 46, 39)),
                                  onPressed: () => updateRequestStatus(
                                      request['id'], "rejected"),
                                ),
                              ],
                            )
                          : Text(request['status'].toUpperCase(),
                              style: TextStyle(
                                  color: request['status'] == "accepted"
                                      ? const Color.fromARGB(255, 35, 137, 146)
                                      : const Color.fromARGB(255, 116, 19, 12),
                                  fontWeight: FontWeight.bold)),
                      onTap: () => showSellerDetailsDialog(context, request),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout action
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 204, 45, 45),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
