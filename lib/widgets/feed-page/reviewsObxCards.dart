import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/feed_Controller.dart';
import 'package:review_app/models/review.dart';
import 'package:review_app/widgets/post_and_comment_card.dart';

class ReviewsObxCards extends StatelessWidget {
 ReviewsObxCards({ Key? key }) : super(key: key);
 final feedController = Get.find<FeedController>();

  @override
  Widget build(BuildContext context){
    return // Display fetched reviews
                    Obx(() {
                      if (feedController.isLoadingReview.value &&
                          feedController.fetchedReviews.isEmpty) {
                        return Container(
                          width: double.infinity,
                          height: Get.height *0.1,
                          color: Colors.white,
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
                        return Column(
                          children: feedController.fetchedReviews
                              .toList()
                              .asMap()
                              .entries
                              .map((e) {
                            int index = e.key;
                            Review review = e.value;
                            print('review from e ${review.airline}');
                            return PostAndCommentCard(review: review);
                          }).toList(),
                        );
                      }
                    });
  }
}