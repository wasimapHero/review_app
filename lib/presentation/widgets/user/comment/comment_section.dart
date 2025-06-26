import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/comment_Controller.dart';
import 'package:review_app/data/models/comment.dart';
import 'package:review_app/core/utils/format_date.dart';
import 'package:review_app/presentation/widgets/user/comment/comment_card.dart';
import 'package:review_app/presentation/widgets/user/comment/post_comment.dart';

class CommentSection extends StatelessWidget {
  final String userImage;
  final String userId;
  final String userName;
  final String reviewId;

  CommentSection({
    Key? key,
    required this.userImage,
    required this.reviewId,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  final commentController = Get.find<CommentController>();

  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade500),
    borderRadius: BorderRadius.circular(15),
  );

  @override
  Widget build(BuildContext context) {
    // column of both comments and post comment
    return Column(
      children: [
        // show all comments

        // ---------------------------------- show only user's comments ----------------

        Obx(
          () => commentController.commentListByUserIdAndRevId.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --------------------------- CommentCard

                    Container(
                        height: 100,
                        child: SingleChildScrollView(
                          child: Column(
                              children: commentController
                                  .commentListByUserIdAndRevId
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map(
                            (e) {
                              // final index = e.key;
                              Comment comment = e.value;
                              final createdAt =
                                  comment.createdAt.toIso8601String();
                              log('commentController.heightOfCommentCard.value : ${commentController.heightOfCommentCard.value}');
                              log('commentController.commentListByUserIdAndRevId.value : ${commentController.commentListByUserIdAndRevId.value[0].content}');

                              return comment.reviewId == reviewId
                                  ? CommentCard(
                                      userImage: userImage ?? '',
                                      userName: userName ?? 'Anonymous',
                                      updatedAt: FormateDateAndTime.getTimeAgo(
                                          createdAt),
                                      commentLikes: '0',
                                      commentText: comment.content ?? '',
                                    )
                                  : SizedBox.shrink();
                            },
                          ).toList()),
                        )),
                    SizedBox(
                      height: 13,
                    ),

                    /// ------------ See more Comments section
                    Text(
                      'See More Comments',
                      style: TextStyle(
                        color: Color(0xFF646464),
                        fontFamily: 'OpenSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 13),
                  ],
                )
              : SizedBox.shrink(),
        ),

        // -------------------------- this is input field for user to comment
        
        PostComment(
          userImage: userImage ?? '',
          userId: userId ?? '', // fallback to empty string if null
          userName: userName ?? 'Anonymous',
          reviewId: reviewId,
        )
      ],
    );
  }
}
