// // import 'package:flutter/material.dart';
// // import 'package:graduation_project/providers/ai_search_provider.dart';
// // import 'package:provider/provider.dart';

// // class AiAiSearchScreen extends StatelessWidget {
// //   final TextEditingController _controller = TextEditingController();

// //   AiAiSearchScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = Provider.of<AiSearchProvider>(context);

// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Search")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _controller,
// //               decoration: const InputDecoration(
// //                 hintText: "Search...",
// //                 suffixIcon: Icon(Icons.search),
// //               ),
// //               onSubmitted: (query) {
// //                 provider.search(query, 10);
// //               },
// //             ),
// //             const SizedBox(height: 20),
// //             if (provider.isLoading)
// //               const CircularProgressIndicator()
// //             else if (provider.error != null)
// //               Text("Error: ${provider.error}")
// //             else
// //               Expanded(
// //                 child: ListView.builder(
// //                   itemCount: provider.results.length,
// //                   itemBuilder: (context, index) {
// //                     final item = provider.results[index];
// //                     return ListTile(
// //                       title: Text(item.name),
// //                       subtitle: Text('${item.category} - \$${item.price}'),
// //                       leading: item.imageUrls.isNotEmpty
// //                           ? Image.network(item.imageUrls.first, width: 50, height: 50, fit: BoxFit.cover)
// //                           : const Icon(Icons.image_not_supported),
// //                     );
// //                   },
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:graduation_project/providers/ai_search_provider.dart';
import 'package:provider/provider.dart';

class AiSearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  AiSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AiSearchProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                   suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: () {
                    provider.search(_controller.text.trim(), 8);
                  },
                ),
                  // suffixIcon: IconButton(
                  //   icon: const Icon(Icons.search),
                  //   onPressed: () {
                  //     _search(_controller.text);
                  //   },
                  // ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onSubmitted: (query) => provider.search(query, 8),
              ),
            ),
          ),
          if (provider.isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: CircularProgressIndicator(),
            )
          else if (provider.error != null)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                provider.error!,
                style: const TextStyle(color: Colors.red),
              ),
            )
          else if (provider.results.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text("No results found."),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                itemCount: provider.results.length,
                itemBuilder: (context, index) {
                  final item = provider.results[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: item.imageUrls.isNotEmpty
                            ? Image.network(
                                item.imageUrls.first,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.image_not_supported),
                              ),
                      ),
                      title: Text(
                        item.name,
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        item.category,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                      trailing: Text(
                        '\$${item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 177, 41, 41),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:graduation_project/providers/ai_search_provider.dart';
// import 'package:provider/provider.dart';

// class AiSearchScreen extends StatefulWidget {
//   const AiSearchScreen({super.key});

//   @override
//   State<AiSearchScreen> createState() => _AiSearchScreenState();
// }

// class _AiSearchScreenState extends State<AiSearchScreen> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     // Clear results AFTER the first frame
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<AiSearchProvider>(context, listen: false).clearResults();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<AiSearchProvider>(context);
//     final theme = Theme.of(context);

//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 8,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: _controller,
//                 decoration: InputDecoration(
//                   hintText: "Search...",
//                   prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                   border: InputBorder.none,
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.send, color: Colors.black),
//                     onPressed: () {
//                       provider.search(_controller.text.trim(), 8);
//                     },
//                   ),
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                 ),
//                 onSubmitted: (query) => provider.search(query, 8),
//               ),
//             ),
//           ),
//           if (provider.isLoading)
//             const Padding(
//               padding: EdgeInsets.only(top: 40.0),
//               child: CircularProgressIndicator(),
//             )
//           else if (provider.error != null)
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Text(
//                 provider.error!,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             )
//           else if (provider.results.isEmpty)
//             const Padding(
//               padding: EdgeInsets.all(20),
//               child: Text("No results found."),
//             )
//           else
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(12),
//                 itemCount: provider.results.length,
//                 itemBuilder: (context, index) {
//                   final item = provider.results[index];
//                   return Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     elevation: 4,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.all(12),
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: item.imageUrls.isNotEmpty
//                             ? Image.network(
//                                 item.imageUrls.first,
//                                 width: 60,
//                                 height: 60,
//                                 fit: BoxFit.cover,
//                               )
//                             : Container(
//                                 width: 60,
//                                 height: 60,
//                                 color: Colors.grey.shade300,
//                                 child: const Icon(Icons.image_not_supported),
//                               ),
//                       ),
//                       title: Text(
//                         item.name,
//                         style: theme.textTheme.titleMedium,
//                       ),
//                       subtitle: Text(
//                         item.category,
//                         style: theme.textTheme.bodySmall
//                             ?.copyWith(color: Colors.grey[600]),
//                       ),
//                       trailing: Text(
//                         '\$${item.price.toStringAsFixed(0)}',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 177, 41, 41),
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
