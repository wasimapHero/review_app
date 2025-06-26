import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/comment_Controller.dart';

class CommentCard extends StatelessWidget {
  final String userImage;
  final String userName;
  final String updatedAt;
  final String commentLikes;
  final String commentText;

  CommentCard({
    Key? key,
    required this.userImage,
    required this.userName,
    required this.updatedAt,
    required this.commentLikes,
    required this.commentText,
  }) : super(key: key);

  final commentController = Get.find<CommentController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 40,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.665),
          color: const Color.fromARGB(255, 236, 243, 246)),
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -----------------------------------> Header   (userId, name etc)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (Get.width - 100) * 0.75,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          image: ( userImage.isNotEmpty)
                              ? DecorationImage(
                                  image: NetworkImage(userImage),
                                  fit: BoxFit.cover,
                                  onError: (_,
                                      __) {}, // You can handle error here if needed
                                )
                              : null,
                          color: (userImage.isEmpty)
                              ? Colors.grey[300]
                              : null,
                        ),
                        child: (userImage.isEmpty)
                            ? Icon(Icons.person, size: 20)
                            : null,
                      ),
                    ),

                    const SizedBox(width: 9),

                    // -------------------------------    user name

                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              color: Color(0xFF232323),
                              fontFamily: 'OpenSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.14,
                            ),
                          ),

                          // -------------------------------    updatedAt
                          Text(updatedAt,
                              style: const TextStyle(
                                color: Color(0xFF232323),
                                fontFamily: 'Manrope',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.24,
                                height: 1.6,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$commentLikes UpVotes',
                style: const TextStyle(
                  color: Color(0xFF232323),
                  fontFamily: 'OpenSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.24,
                  height: 1.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // -----------------------------------> comment text
          Column(
            children: [
              Text(
                commentText,
                style: const TextStyle(
                  color: Color(0xFF232323),
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.28,
                  height: 1.57,
                ),
              ),

              const SizedBox(
                height: 6,
              ),

              // -----------------------   see more of comment button
              // -------------------------    See more Option
              const SizedBox(height: 8),
              if (commentText.length > 100 &&
                  !commentController.isExpanded.value)
                GestureDetector(
                  onTap: commentController.toggleExpanded,
                  child: Text(
                    'see all..',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: 'OpenSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ),
              if (commentController.isExpanded.value)
                GestureDetector(
                  onTap: commentController.toggleExpanded,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "see less..",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // -----------------------------------> bottom
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    // upvote icon
                    SizedBox(
                      height: 25,
                      child: Image.asset(
                          'assets/images/icons/chevron-double-up.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Upvote',
                      style: TextStyle(
                        color: Color(0xFF232323),
                        fontFamily: 'OpenSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.28,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 23),

              // reply icon
              SizedBox(
                height: 25,
                child: Image.asset('assets/images/icons/reply.png'),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Reply',
                style: TextStyle(
                  color: Color(0xFF232323),
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.28,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
