import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:review_app/controller/feed_Controller.dart';
import 'package:review_app/models/review.dart';
import 'package:review_app/utils/format_date.dart';
import 'package:review_app/widgets/post_card.dart';
import 'package:review_app/widgets/post_comment_section.dart';

class PostAndCommentCard extends StatelessWidget {
  PostAndCommentCard({Key? key, required this.review}) : super(key: key);

  final Review review;
  final feedController = Get.find<FeedController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      margin: EdgeInsets.only(bottom: 13),
      child: Column( 
        children: [
          // Post Cards list View
            PostCard(
            userImage: review.userImage!.toString() ,
            userName: review.userName!.length>20 ? review.userName!.substring(0, 20) : review.userName!,
            timeAgo: FormateDateAndTime.getTimeAgo(
                review.createdAt.toIso8601String()),
            rating: review.rating,
            badges: [
              review.departureAirport,
              review.arrivalAirport,
              review.airline,
              review.travelClass,
              FormateDateAndTime.getMonthYear(review.travelDate.toIso8601String())
              
            ],
            content:
                review.reviewText ?? '',
            postImages: review.images,
            likes: review.likes.toString(),
            commentsNumber: '20 Comments',
            comments: [],
          ),
          const SizedBox(height: 10),

          /// Post Comment Section
          PostCommentSection(),
        ],
      ),
    );
  }
}
