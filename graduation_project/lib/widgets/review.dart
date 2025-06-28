// import 'package:flutter/material.dart';
// import 'package:graduation_project/models/reviews_model.dart';
// import 'package:provider/provider.dart';
// import '../../providers/review_provider.dart';
// import '../../providers/login_provider.dart'; // for token

// class AddReviewWidget extends StatefulWidget {
//   final int productId;

//   const AddReviewWidget({super.key, required this.productId});

//   @override
//   State<AddReviewWidget> createState() => _AddReviewWidgetState();
// }

// class _AddReviewWidgetState extends State<AddReviewWidget> {
//   final _formKey = GlobalKey<FormState>();
//   final _commentController = TextEditingController();
//   int _rating = 5;
//   @override
//   Widget build(BuildContext context) {
//     final reviewProvider = Provider.of<ReviewProvider>(context);
//     final authProvider = Provider.of<LoginProvider>(context);

//     return SingleChildScrollView(
//       // ⬅️ fix scroll overflow
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('Add Review',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               DropdownButtonFormField<int>(
//                 value: _rating,
//                 items: List.generate(
//                   5,
//                   (index) => DropdownMenuItem(
//                       value: index + 1, child: Text('${index + 1}')),
//                 ),
//                 onChanged: (value) => setState(() => _rating = value!),
//                 decoration: const InputDecoration(labelText: 'Rating'),
//               ),
//               TextFormField(
//                 controller: _commentController,
//                 maxLines: 3,
//                 decoration: const InputDecoration(labelText: 'Comment'),
//                 validator: (value) => value == null || value.isEmpty
//                     ? 'Please enter a comment'
//                     : null,
//               ),
//               const SizedBox(height: 12),
//               ElevatedButton(
//                 onPressed: reviewProvider.isLoading
//                     ? null
//                     : () async {
//                         if (_formKey.currentState!.validate()) {
//                           final review = Review(
//                             rating: _rating,
//                             comment: _commentController.text,
//                             productId: widget.productId,
//                           );

//                           await reviewProvider.submitReview(
//                               review, authProvider.token);
//                           await reviewProvider.fetchReviews(
//                               widget.productId, authProvider.token);

//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             content: Text(
//                                 reviewProvider.message ?? 'Review submitted'),
//                           ));
//                           Navigator.pop(context);
//                           _commentController.clear();
//                         }
//                       },
//                 child: reviewProvider.isLoading
//                     ? const CircularProgressIndicator()
//                     : const Text('Submit Review'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:graduation_project/models/reviews_model.dart';
import 'package:provider/provider.dart';
import '../../providers/review_provider.dart';
import '../../providers/login_provider.dart';

class AddReviewWidget extends StatefulWidget {
  final int productId;

  const AddReviewWidget({super.key, required this.productId});

  @override
  State<AddReviewWidget> createState() => _AddReviewWidgetState();
}

class _AddReviewWidgetState extends State<AddReviewWidget> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    final authProvider = Provider.of<LoginProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(31, 62, 49, 49),
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Your Review',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 164, 26, 26),
                ),
              ),
              const SizedBox(height: 20),

              // Rating Dropdown
              DropdownButtonFormField<int>(
                value: _rating,
                items: List.generate(
                  5,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1} Star${index == 0 ? '' : 's'}'),
                  ),
                ),
                onChanged: (value) => setState(() => _rating = value!),
                decoration: InputDecoration(
                  labelText: 'Rating',
                  filled: true,
                  fillColor: const Color(0xFFF0F4F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Comment TextField
              TextFormField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Comment',
                  hintText: 'Write your feedback here...',
                  filled: true,
                  fillColor: const Color(0xFFF0F4F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a comment' : null,
              ),

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  icon: reviewProvider.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send_outlined, color: Colors.white),
                  label: Text(
                    reviewProvider.isLoading ? 'Submitting...' : 'Submit Review',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 168, 28, 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: reviewProvider.isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            final review = Review(
                              rating: _rating,
                              comment: _commentController.text,
                              productId: widget.productId,
                            );

                            await reviewProvider.submitReview(
                              review,
                              authProvider.token,
                            );

                            await reviewProvider.fetchReviews(
                                widget.productId, authProvider.token);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  reviewProvider.message ?? 'Review submitted successfully!',
                                ),
                              ),
                            );
                            Navigator.pop(context);
                            _commentController.clear();
                          }
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
