import 'package:flutter/material.dart';
import 'package:graduation_project/models/reviews_model.dart';
import 'package:provider/provider.dart';
import '../../providers/review_provider.dart';
import '../../providers/login_provider.dart'; // for token

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
      // ⬅️ fix scroll overflow
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Review',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              DropdownButtonFormField<int>(
                value: _rating,
                items: List.generate(
                  5,
                  (index) => DropdownMenuItem(
                      value: index + 1, child: Text('${index + 1}')),
                ),
                onChanged: (value) => setState(() => _rating = value!),
                decoration: const InputDecoration(labelText: 'Rating'),
              ),
              TextFormField(
                controller: _commentController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Comment'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a comment'
                    : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
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
                              review, authProvider.token);
                          await reviewProvider.fetchReviews(
                              widget.productId, authProvider.token);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                reviewProvider.message ?? 'Review submitted'),
                          ));
                          Navigator.pop(context);
                          _commentController.clear();
                        }
                      },
                child: reviewProvider.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Submit Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
