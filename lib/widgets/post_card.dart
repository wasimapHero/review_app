import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/feed_Controller.dart';
import 'package:review_app/models/comment.dart';
import 'package:review_app/widgets/badge_chip.dart';
import 'package:review_app/widgets/comment_card.dart';

class PostCard extends StatelessWidget {
  final String? userImage;
  final String userName;
  final String timeAgo;
  final int? rating;
  final List<String>? badges;
  final String content;
  final List<String>? postImages;
  final String likes;
  final String? commentsNumber;
  final List<Comment>? comments;

  const PostCard({
    Key? key,
     this.userImage,
    required this.userName,
    required this.timeAgo,
    this.rating,
    this.badges,
    required this.content,
    this.postImages,
    required this.likes,
    this.comments,
    this.commentsNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final feedController = Get.find<FeedController>();
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // userImage, name, posted time ago 
              Flexible(
                flex: 3,
                child: Row(
                  children: [
                    userImage!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(87),
                            child: Image.network(
                              userImage!,
                              width: 42,
                              height: 42,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(87),
                            child: Container(
                              width: 42,
                              height: 42,
                              color: Colors.orangeAccent,
                            ),
                          ),
                    const SizedBox(width: 11),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Color(0xFF555555),
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                            height: 1.3,
                          ),
                        ),
                        Text(
                          timeAgo,
                          style: const TextStyle(
                            color: Color(0xFF646464),
                            fontFamily: 'OpenSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.56,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // more and rating 
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // more option
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_horiz,
                          size: 22,
                        ),
                        color: Colors.black87,
                      ),
                    ),

                    // Rating
                    if (rating != null)
                      SizedBox(
                        // width: Get.width * 0.45,
                        child: Row(
                          children: [
                            // rating stars
                            Row(
                              children: List.generate(5, (index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: SizedBox(
                                    width: 14,
                                    child: GestureDetector(
                                      child: Icon(
                                        index < rating!.toInt()
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Color(0xFFD8A31C),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${rating.toString()}.0',
                              style: const TextStyle(
                                color: Color(0xFF646464),
                                fontFamily: 'OpenSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.55,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),

          // Badges
          if (badges != null) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 14,
              runSpacing: 8,
              children: badges!.asMap().entries.map((entry) {
                final index = entry.key;
                final badge = entry.value;
                return BadgeChip(
                  text: badge,
                  onTap: () => print('Badge $index tapped: $badge'),
                );
              }).toList(),
            ),
          ],

          const SizedBox(height: 28),

          // Content review
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  maxLines: feedController.isExpanded.value ? null : 3,
                  overflow:
                      feedController.isExpanded.value ? TextOverflow.visible : TextOverflow.fade,
                  style: const TextStyle(
                    color: Color(0xFF404040),
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.43,
                  ),
                ),
                const SizedBox(height: 8),
                if (content.length > 100 && !feedController.isExpanded.value)
                GestureDetector(
                  onTap: feedController.toggleExpanded,
                  child: Text(
                    'See more',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: 'OpenSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ),
                if (feedController.isExpanded.value)
            GestureDetector(
              onTap: feedController.toggleExpanded,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "See less",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Post Image
          // postImages != null ? Image.network(
          //   postImages![0],
          //   width: double.infinity,
          //   height: 158,
          //   fit: BoxFit.cover,
          // ) :
          Image.asset(
            'assets/images/products/air-transat-plane-avion-1200x628.jpg',
            width: double.infinity,
            height: 158,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 6),

          // Like and Comment Count
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                // lIke number
                Text(
                  likes,
                  style: const TextStyle(
                    color: Color(0xFF232323),
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.28,
                    height: 1.6,
                  ),
                ),
                const SizedBox(width: 11),

                // comment number
                Text(
                  commentsNumber!,
                  style: const TextStyle(
                    color: Color(0xFF232323),
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.28,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // like icon
                    Icon(Icons.thumb_up_alt_outlined),
                    const SizedBox(width: 9),
                    const Text(
                      'Like',
                      style: TextStyle(
                        color: Color(0xFF232323),
                        fontFamily: 'OpenSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.3,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // share icon
                    SizedBox(
                      height: 25,
                      child: Image.asset('assets/images/icons/share.png'),
                    ),
                    const SizedBox(width: 9),
                    const Text(
                      'Share',
                      style: TextStyle(
                        color: Color(0xFF232323),
                        fontFamily: 'OpenSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 11),

          // ----------------------- Comments Section ----------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // call comments list here
              // map them
              // then list them again- toList()

              // CommentCard(
              //   userImage: commentUserImage,
              //   userName: commentUserName,
              //   updatedAt: updatedAt,
              //   commentLikes: commentLikes,
              //   commentText: commentText,
              // ),
              SizedBox(
                height: 13,
              ),

              /// ------ See more Comments section
              const Text(
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
          ),
        ],
      ),
    );
  }
}
