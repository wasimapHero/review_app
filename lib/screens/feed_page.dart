
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/feed_Controller.dart';
import 'package:review_app/controller/myAccount_Controller.dart';
import 'package:review_app/controller/userInfoFetch_Controller.dart';
import 'package:review_app/controller/userInfo_Controller.dart';
import 'package:review_app/routes/app_routes.dart';
import 'package:review_app/widgets/feed-page/actionButtonRow.dart';
import 'package:review_app/widgets/feed-page/action_button.dart';
import 'package:review_app/widgets/feed-page/reviewsObxCards.dart';

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

      //  ------------------ AppBar
      appBar: _appBar(),

      //  ------------------ body
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
              //  ------------------ Page Content
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // --------------Action Buttons Row
                    ActionButtonRow(),
                    const SizedBox(height: 12),

                    // ---------------- Search Button row
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

                    // --------- Featured Image
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

                    // ------------ All Reviews List
                    ReviewsObxCards()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  AppBar _appBar() {
    return AppBar(
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
      );
      
  }
}



// according to above Review Model, Table aql, Comment Model, table sql, write code of 'FeedPage' where the UI is this: