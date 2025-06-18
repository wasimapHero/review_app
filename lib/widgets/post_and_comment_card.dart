import 'package:flutter/material.dart';
import 'package:review_app/widgets/post_card.dart';
import 'package:review_app/widgets/post_comment_section.dart';

class PostAndCommentCard extends StatelessWidget {
const PostAndCommentCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      margin: EdgeInsets.only(bottom: 13),
      child: Column(
        children: [
                // Post Cards list View
                    const PostCard(
                      userImage: 'assets/images/icons/search.png',
                      userName: 'Dianne Russell',
                      timeAgo: '1 day ago',
                      rating: 5,
                      badges: [
                        'LHR-DEL',
                        'Air-India',
                        'Business Class',
                        'July 2023'
                      ],
                      content:
                          'Stay tuned for a smoother, more convenient experience right at your fingertips , a smoother, more convenient a ​smoother, more convenient other, more convenient experience right at your ',
                      postImage: 'assets/images/icons/search.png',
                      likes: '30 Likes',
                      comments: '20 Comments',
                      commentUserImage: 'assets/images/user/user.png',
                      commentUserName: 'Darron Levesque',
                      updatedAt: '3 min ago',
                      commentLikes: '5 Upvotes',
                      commentText:
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis',
                      
                    ),
                    const SizedBox(height: 10),


        /// Post Comment Section
                    PostCommentSection(),
        ],
      ),
    );
  }
}