

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/comment_Controller.dart';
import 'package:review_app/data/controller/feed_Controller.dart';
import 'package:review_app/data/models/review.dart';
import 'package:review_app/core/utils/format_date.dart';
import 'package:review_app/presentation/widgets/post_card.dart';
import 'package:review_app/presentation/widgets/user/comment/comment_section.dart';


class ReviewAndCommentCard extends StatelessWidget {
  ReviewAndCommentCard({Key? key, required this.review}) : super(key: key);

  final Review review;
  final feedController = Get.find<FeedController>();
  final commentController = Get.find<CommentController>();

  @override
  Widget build(BuildContext context) {
    // Guard clause: return empty if review.id is null
    if (review.id == null) {
      return const SizedBox(); // or show a fallback error widget
    }

    // fetch Comments for each Review by reviewId
    commentController.onTapped.value = false;

    final userId = commentController.supabase.auth.currentUser?.id;
    if (userId != null) {
      commentController.fetchCommentsByUserIdAndReviewId(userId, review.id!);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      margin: const EdgeInsets.only(bottom: 13),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --------------- Review Card
          PostCard(
            userImage: review.userImage?.toString() ?? '',
            userName: (review.userName ?? 'Unknown').length > 20
                ? review.userName!.substring(0, 20)
                : review.userName ?? 'Unknown',
            timeAgo: FormateDateAndTime.getTimeAgo(
                review.createdAt.toIso8601String()),
            rating: review.rating,
            badges: [
              review.departureAirport,
              review.arrivalAirport,
              review.airline,
              review.travelClass,
              FormateDateAndTime.getMonthYear(
                  review.travelDate.toIso8601String())
            ],
            content: review.reviewText ?? '',
            postImages: review.images,
            likes: review.likes.toString(),
            commentsNumber: '20 Comments',
            comments: [],
          ),

          const SizedBox(height: 4),

          // --------------- Comment Section
          

          CommentSection(
            userImage: review.userImage ?? '',
            reviewId: review.id!, // now safe due to early null check
            userId: review.userId,
            userName: review.userName ?? 'Anonymous',
          ) ,
        ],
      ),
    );
  }
}
