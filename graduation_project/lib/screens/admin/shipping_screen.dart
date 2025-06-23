// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../providers/login_provider.dart';
// import '../../providers/shipping_provider.dart';
// import 'package:intl/intl.dart';

// class ShippingScreen extends StatefulWidget {
//   const ShippingScreen({super.key});

//   @override
//   State<ShippingScreen> createState() => _ShippingScreenState();
// }

// class _ShippingScreenState extends State<ShippingScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final token = Provider.of<LoginProvider>(context, listen: false).token;
//       Provider.of<ShippingProvider>(context, listen: false)
//           .fetchShipping(token);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ShippingProvider>(context);
//     final shipping = provider.shipping;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shipping Information'),
//         centerTitle: true,
//       ),
//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : provider.error != null
//               ? Center(
//                   child: Text(
//                     'Error: ${provider.error}',
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 )
//               : shipping == null
//                   ? const Center(child: Text('No shipping data available.'))
//                   : SizedBox(
//                       height: 200,
//                       child: Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Container(
//                           width: screenWidth,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16),
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color.fromARGB(255, 224, 46, 46),
//                                 Color.fromARGB(255, 251, 187, 187)
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 10,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Row(
//                                   children: [
//                                     Icon(Icons.local_shipping_outlined,
//                                         size: 28, color: Color.fromARGB(255, 249, 249, 249)),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       'Shipping Details',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color.fromARGB(255, 255, 255, 255),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.attach_money,
//                                         color: Colors.black54),
//                                     const SizedBox(width: 8),
//                                     const Text(
//                                       'Cost: ',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 16),
//                                     ),
//                                     Text(
//                                       '\$${shipping.cost}',
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.update,
//                                         color: Colors.black54),
//                                     const SizedBox(width: 8),
//                                     const Text(
//                                       'Last Updated: ',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 16),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         DateFormat('yyyy-MM-dd – hh:mm a')
//                                             .format(
//                                                 shipping.updatedAt.toLocal()),
//                                         style: const TextStyle(fontSize: 16),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/login_provider.dart';
import '../../providers/shipping_provider.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Provider.of<LoginProvider>(context, listen: false).token;
      Provider.of<ShippingProvider>(context, listen: false)
          .fetchShipping(token);
    });
  }

  Future<void> _showUpdateDialog(BuildContext context) async {
    final token = Provider.of<LoginProvider>(context, listen: false).token;
    final provider = Provider.of<ShippingProvider>(context, listen: false);
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Shipping Cost'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'New Shipping Cost'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
            
              onPressed: () async {
                final newCost = double.tryParse(controller.text);
                if (newCost != null) {
                  Navigator.pop(context);
                  await provider.updateShippingCost(token, newCost);
                }
              },
              child: const Text('Update', style: TextStyle(color: Color.fromARGB(255, 179, 45, 45)),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShippingProvider>(context);
    final shipping = provider.shipping;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Information'),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(
                  child: Text(
                    'Error: ${provider.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : shipping == null
                  ? const Center(child: Text('No shipping data available.'))
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 253, 227, 227),
                                  Color.fromARGB(255, 235, 141, 141)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.local_shipping_outlined,
                                          size: 28, color: Color.fromARGB(255, 0, 0, 0)),
                                      SizedBox(width: 8),
                                      Text(
                                        'Shipping Details',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const Icon(Icons.attach_money,
                                          color: Colors.black54),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Cost: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        '\$${shipping.cost}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Icon(Icons.update,
                                          color: Colors.black54),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Last Updated: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Expanded(
                                        child: Text(
                                          DateFormat('yyyy-MM-dd – hh:mm a')
                                              .format(
                                                  shipping.updatedAt.toLocal()),
                                          style:
                                              const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () => _showUpdateDialog(context),
                            icon: const Icon(Icons.edit_outlined, color: Colors.white,),
                            label: const Text('Update Shipping Cost', style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                                  backgroundColor: const Color.fromARGB(255, 185, 30, 30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          )
                        ],
                      ),
                    ),
    );
  }
}
