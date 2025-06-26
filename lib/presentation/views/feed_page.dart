import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/feed_Controller.dart';
import 'package:review_app/data/controller/myAccount_Controller.dart';
import 'package:review_app/data/controller/userInfoFetch_Controller.dart';
import 'package:review_app/data/controller/userInfo_Controller.dart';
import 'package:review_app/app/routes/app_routes.dart';
import 'package:review_app/presentation/widgets/feed-page/actionButtonRow.dart';
import 'package:review_app/presentation/widgets/feed-page/action_button.dart';
import 'package:review_app/presentation/widgets/feed-page/reviewsCards.dart';

class FeedPage extends StatelessWidget {
  FeedPage({Key? key}) : super(key: key);

  final feedController = Get.find<FeedController>();
  final userInfoFetchController = Get.find<UserinfofetchController>();
  final userInfoController = Get.find<UserinfoController>();
  final myAccountController = Get.find<MyAccountController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),

        //  ------------------ AppBar
        appBar: appBar(),

        //  ------------------ body
        body: Container(
          padding: EdgeInsets.only(top: 15),
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //  ------------------ Page Content
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),

                      // --------------Action Buttons Row ------------
                      // ------------- share experience && ask a ques-------------
                      ActionButtonRow(),
                      const SizedBox(height: 12),

                      // ---------------- Search Button row
                      SizedBox(
                        width: Get.width - 40,
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
                          width: Get.width - 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // ------------ All Reviews List
                      ReviewsCards()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
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

        // --------------------------------  User Profile Picture
        GestureDetector(onTap: () {
          Get.toNamed(TRouteNames.myAccountPage,
              arguments:
                  Map<String, String>.from(feedController.fetchedUserInfo));
        }, child: // user Image
                Obx(() {
          final info = feedController.fetchedUserInfo.value;
          final userImage = info['user_image'] as String?;

          ImageProvider imageProvider;

          bool isValidUrl(String? url) {
            if (url == null || url.isEmpty) return false;
            final uri = Uri.tryParse(url);
            return uri != null &&
                (uri.scheme == 'http' || uri.scheme == 'https');
          }

          if (isValidUrl(userImage)) {
            imageProvider = NetworkImage(userImage!);
          } else {
            imageProvider = const AssetImage('assets/images/user/user.png');
          }

          return CircleAvatar(
            radius: 20,
            backgroundImage: imageProvider,
          );
        })

//

            ),

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