import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/comment_Controller.dart';

class PostComment extends StatelessWidget {

    final String userImage;
  final String userId;
  final String userName;
  final String reviewId;
 PostComment({ Key? key, required this.userImage, required this.userId, required this.userName, required this.reviewId }) : super(key: key);


  final commentController = Get.find<CommentController>();

  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade500),
    borderRadius: BorderRadius.circular(15),
  );
  @override
  Widget build(BuildContext context){
       var sendIconWidth = 29.0.obs;
    var sendIconHeight = 29.0.obs;
    return Container(
          child: Column(
            children: [
              // Commentor user Id Icon
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(132),
                    child: Image.network(
                      userImage,
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      children: [
                        // ErrorText
                        Obx(
                          () => Text(commentController.onTapped.value? 'Please type something first' : ''),
                        ),

                        // Comment Input
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF2F4F8),
                              borderRadius: BorderRadius.circular(17.335),
                              border: Border.fromBorderSide(
                                BorderSide(color: Colors.grey.shade500),
                              )),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // comment input field
                              Expanded(
                                child: TextFormField(
                                  controller:
                                      commentController.getController(reviewId),
                                  maxLines: 150,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: 'write your Comment',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF646464),
                                      fontFamily: 'OpenSans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.12,
                                      height: 1.3,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(left: 5),
                                  ),
                                ),
                              ),

                              // send icon (for commenting)
                              Obx(
                                () => GestureDetector(
                                  onTap: () async {
                                    // commentController.setOnTappedTrue(reviewId);
                                    commentController.onTapped.value = true;

                                    sendIconHeight.value = 26;
                                    sendIconWidth.value = 26;
                                    Future.delayed(
                                      Duration(milliseconds: 200),
                                      () {
                                        sendIconWidth.value = 29;
                                        sendIconHeight.value = 29;
                                      },
                                    );

                                    //
                                    final text = commentController
                                        .getController(reviewId)
                                        .text
                                        .trim();

                                        // if (commentController.onTappedList[reviewId]! &&
                                      //   text.isNotEmpty) {
                                          
                                      // commentController.showErrorTextList[reviewId]!;
                                    if (commentController.onTapped.value &&
                                        text.isNotEmpty) {

                                      commentController.showErrorText;  // 

                                      // Post comment logic
                                      log("Posting comment for $reviewId: $text");

                                      await commentController.postCommentToDB(
                                          reviewId,
                                          userId,
                                          userName,
                                          userImage);

                                         await commentController.fetchCommentsByUserIdAndReviewId(commentController.supabase.auth.currentUser!.id, reviewId);
                                        

                                    
                                    } else if (commentController.
                                            onTapped.value &&
                                        text.isEmpty) {
                                      commentController.showErrorText;
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/images/icons/send.png',
                                    width: sendIconWidth.value,
                                    height: sendIconHeight.value,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 25,
              )
            ],
          ),
        )
      
      ;
  }
}