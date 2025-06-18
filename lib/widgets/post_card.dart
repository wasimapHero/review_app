import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/widgets/badge_chip.dart';
import 'package:review_app/widgets/comment_card.dart';

class PostCard extends StatelessWidget {
  final String userImage;
  final String userName;
  final String timeAgo;
  final int? rating;
  final List<String>? badges;
  final String content;
  final String postImage;
  final String likes;
  final String comments;
  final String commentUserImage;
  final String commentUserName;
  final String updatedAt;
  final String commentLikes;
  final String commentText;

  const PostCard({
    Key? key,
    required this.userImage,
    required this.userName,
    required this.timeAgo,
    this.rating,
    this.badges,
    required this.content,
    required this.postImage,
    required this.likes,
    required this.comments,
    required this.commentUserImage,
    required this.commentUserName,
    required this.updatedAt,
    required this.commentLikes,
    required this.commentText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(87),
                    child: Image.asset(
                      userImage,
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
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
              // Rating
              if (rating != null)
                Row(
                  children: [
                    // rating stars
                    const SizedBox(width: 62),
                    Text(
                      rating.toString()!,
                      style: const TextStyle(
                        color: Color(0xFF646464),
                        fontFamily: 'OpenSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.55,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
            ],
          ),

          // Badges
          if (badges != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              height: 29,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: badges!.length,
                separatorBuilder: (context, index) => const SizedBox(width: 14),
                itemBuilder: (context, index) => BadgeChip(text: badges![index], onTap: () => print('BadgeChip tags'),),
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style: const TextStyle(
                  color: Color(0xFF404040),
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
              const SizedBox(height: 8),
               GestureDetector(
                onTap: () {  },
                child: Text('See more',style: TextStyle(
                  color: Color(0xFF646464),
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),),
                
                
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Post Image
          Image.asset(
            postImage,
            width: double.infinity,
            height: 358,
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
                  comments,
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
              CommentCard(
                userImage: commentUserImage,
                userName: commentUserName,
                updatedAt: updatedAt,
                commentLikes: commentLikes,
                commentText: commentText,
              ),
              SizedBox(height: 13,),

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
