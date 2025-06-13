import 'package:flutter/material.dart';
import 'package:graduation_project/models/product_review.dart';
import 'package:graduation_project/models/reviews_model.dart';
import 'package:graduation_project/services/api_service.dart';

class ReviewProvider extends ChangeNotifier {
  final ApiService _service = ApiService();
  bool isLoading = false;
  String? message;

  Future<void> submitReview(Review review, String token) async {
    isLoading = true;

    message = await _service.addReview(review, token);

    isLoading = false;
    notifyListeners();
  }

  List<ProductReview> _reviews = [];

  List<ProductReview> get reviews => _reviews;
  Future<void> fetchReviews(int productId, String token) async {
    isLoading = true;
  
    _reviews = await _service.getReviews(productId, token);

    isLoading = false;
    notifyListeners();
  }
}
