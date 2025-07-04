import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/comment_Controller.dart';
import 'package:review_app/data/controller/feed_Controller.dart';
import 'package:review_app/data/models/review.dart';
import 'package:review_app/presentation/widgets/review_and_comment_card.dart';

class ReviewsCards extends StatelessWidget {
  ReviewsCards({Key? key}) : super(key: key);

  final feedController = Get.find<FeedController>();
  final commentController = Get.find<CommentController>();

  @override
  Widget build(BuildContext context) {
    return // Display fetched reviews
        Obx(() {
      if (feedController.isLoadingReview.value &&
          feedController.fetchedReviews.isEmpty) {
        return Container(
          width: Get.width - 40,
          color: const Color.fromARGB(255, 208, 114, 114),
          child: Column(
            children: [
              SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(),
              ),
              Text('Loading..'),
              Text('No reviews available.')
            ],
          ),
        );
      } else {
        return SizedBox(
          width: Get.width - 40,
          child: Column(
            children:
                feedController.fetchedReviews.toList().asMap().entries.map((e) {
              // int index = e.key;
              Review review = e.value;

              if (review.id != null) {
                commentController.reviewIdFromReviewCard.value = review.id!;
                log('commentController.reviewIdFromReviewCard.value: ${commentController.reviewIdFromReviewCard.value}');
              } else {
                // Handle the null case
                log('Error: review.id is null');
                // You may choose to reset or not assign the value
                commentController.reviewIdFromReviewCard.value = '';
              }
              log('review from e ${review.airline}');

              return ReviewAndCommentCard(review: review);
            }).toList(),
          ),
        );
      }
    });
  }
}
