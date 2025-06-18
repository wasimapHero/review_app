import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/widgets/action_button.dart';
import 'package:review_app/widgets/post_and_comment_card.dart';
import 'package:review_app/widgets/post_card.dart';
import 'package:review_app/widgets/post_comment_section.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 153, 154, 155),
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
                        'Airline Review',
                        style: TextStyle(
                          color: Color(0xFF232323),
                          fontFamily: 'Plus Jakarta Sans',
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
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(
              'assets/images/user/user.png', // Replace with actual image URL
            ),
          ),

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
        constraints:  BoxConstraints(maxWidth: 480),
        decoration:  BoxDecoration(
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
                        SizedBox(
                          width: Get.width * 0.50,
                          child: ActionButton(
                              text: "Share your experience",
                              iconWidth: 20,
                              iconHeight: 30,
                              fontSize: 13,
                              letterSpacing: 0.26,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              icon: 'assets/images/icons/share-experience.png'),
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

                    PostAndCommentCard(),

                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// according to above Review Model, Table aql, Comment Model, table sql, write code of 'FeedPage' where the UI is this: