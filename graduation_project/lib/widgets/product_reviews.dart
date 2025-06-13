// import 'package:flutter/material.dart';
// import 'package:graduation_project/models/product_review.dart';
// import 'package:graduation_project/providers/review_provider.dart';
// import 'package:provider/provider.dart';
// import '../../providers/login_provider.dart'; // to get token

// class ProductReviewsList extends StatelessWidget {
//   final int productId;

//   const ProductReviewsList({super.key, required this.productId});

//   @override
//   Widget build(BuildContext context) {
//     final reviewProvider = Provider.of<ReviewProvider>(context);
//     final token = Provider.of<LoginProvider>(context).token;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Customer Reviews",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 10),
//         reviewProvider.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : reviewProvider.reviews.isEmpty
//                 ? const Text("No reviews yet.")
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: reviewProvider.reviews.length,
//                     itemBuilder: (context, index) {
//                       final ProductReview review =
//                           reviewProvider.reviews[index];
//                       return Card(
//                         child: ListTile(
//                           title: Text(review.userName),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Rating: ${review.userRating}/5"),
//                               Text(review.comment),
//                               Text(
//                                 "${review.createdAt.toLocal()}"
//                                     .split(' ')[0],
//                                 style: const TextStyle(
//                                     fontSize: 12, color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation_project/models/product_review.dart';
import 'package:graduation_project/providers/review_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/login_provider.dart'; // to get token

class ProductReviewsList extends StatelessWidget {
  final int productId;

  const ProductReviewsList({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    final token = Provider.of<LoginProvider>(context).token;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            "Customer Reviews",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        reviewProvider.isLoading
            ? const Center(child: CircularProgressIndicator()):
             reviewProvider.reviews.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("No reviews yet."),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviewProvider.reviews.length,
                    itemBuilder: (context, index) {
                      final ProductReview review =
                          reviewProvider.reviews[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Username and rating
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    review.userName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    children: List.generate(
                                      review.userRating,
                                      (i) => const Icon(Icons.star,
                                          size: 18, color: Colors.amber),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              /// Comment
                              Text(
                                review.comment,
                                style: const TextStyle(fontSize: 15),
                              ),
                              const SizedBox(height: 8),

                              /// Date
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  DateFormat('MMM d, yyyy').format(
                                      review.createdAt.toLocal()),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
      ],
    );
  }
}
