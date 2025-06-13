import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/product_reviews.dart';

class ReviewPage extends StatelessWidget {
  int productId;
   ReviewPage({super.key, required this.productId,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Customer Reviews"),),
      body: SingleChildScrollView(child:       ProductReviewsList(productId: productId, reviewsNum: 0),
)
    );
  }
}