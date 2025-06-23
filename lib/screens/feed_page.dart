import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/feed_Controller.dart';
import 'package:review_app/controller/myAccount_Controller.dart';
import 'package:review_app/controller/userInfoFetch_Controller.dart';
import 'package:review_app/controller/userInfo_Controller.dart';
import 'package:review_app/models/review.dart';
import 'package:review_app/routes/app_routes.dart';
import 'package:review_app/widgets/action_button.dart';
import 'package:review_app/widgets/post_and_comment_card.dart';

class FeedPage extends StatelessWidget {
  FeedPage({Key? key}) : super(key: key);

  final feedController = Get.find<FeedController>();
  final userInfoFetchController = Get.find<UserinfofetchController>();
  final userInfoController = Get.find<UserinfoController>();
  final myAccountController = Get.find<MyAccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Airline Review',
            style: TextStyle(
              color: Color(0xFF232323),
              fontFamily: 'OpenSans',
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          // Notification Icon
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Notification action
            },
          ),

          // User Profile Picture
          GestureDetector(onTap: () {
            Get.toNamed(TRouteNames.myAccountPage,
                arguments:
                    Map<String, String>.from(feedController.fetchedUserInfo));
          }, child: // user Image
              Obx(() {
            final info = feedController.fetchedUserInfo.value;
            final userImage = info['user_image']; // String?
            // If the map is empty or user_image is null/empty, show placeholder
            if (userImage == null || userImage.isEmpty) {
              return CircleAvatar(
                radius: 20,
                child: Image.asset('assets/images/user/user.png'),
              );
            }

            // Otherwise show the network image
            return CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(userImage),
            );
          })),

          // Menu Icon
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Menu action
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: 480),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 245, 245),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Content
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // Action Buttons Row
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed(TRouteNames.shareFormPopup),
                          child: SizedBox(
                            width: Get.width * 0.50,
                            child: ActionButton(
                                text: "Share your experience",
                                iconWidth: 20,
                                iconHeight: 30,
                                fontSize: 13,
                                letterSpacing: 0.26,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                icon:
                                    'assets/images/icons/share-experience.png'),
                          ),
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: Get.width * 0.38,
                          child: ActionButton(
                              text: "Ask a question",
                              iconWidth: 20,
                              iconHeight: 30,
                              fontSize: 13,
                              letterSpacing: 0.26,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 13),
                              icon: 'assets/images/icons/ask_a_ques.png'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Search Button
                    SizedBox(
                      width: double.infinity,
                      child: ActionButton(
                          text: "Search",
                          iconWidth: 20,
                          iconHeight: 30,
                          fontSize: 13,
                          letterSpacing: 0.26,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 7),
                          icon: 'assets/images/icons/search.png'),
                    ),

                    const SizedBox(height: 21),

                    // Featured Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/products/air-transat-plane-avion-1200x628.jpg',
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // PostAndCommentCard(),

                    // Display fetched reviews
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
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDelayedDialog() {
    // Show dialog automatically after screen is loaded
    Future.delayed(Duration.zero, () {
      Get.dialog(
        const AlertDialog(
          // title: Text('Auto Dialog'),
          content: SizedBox(
              height: 15, width: 15, child: CircularProgressIndicator()),
        ),
        barrierDismissible: false,
      );

      // Close it after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (Get.isDialogOpen ?? false) {
          Get.back(); // Closes the dialog
          Get.offAllNamed(TRouteNames.feedPage);
        }
      });
    });
  }
}


// according to above Review Model, Table aql, Comment Model, table sql, write code of 'FeedPage' where the UI is this: