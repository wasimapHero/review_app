import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String userImage;
  final String userName;
  final String updatedAt;
  final String commentLikes;
  final String commentText;

  const CommentCard({
    Key? key,
    required this.userImage,
    required this.userName,
    required this.updatedAt,
    required this.commentLikes,
    required this.commentText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F8),
        borderRadius: BorderRadius.circular(12.665),
      ),
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      userImage,
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 9),
                  
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         userName,
                  //         style: const TextStyle(
                  //           color: Color(0xFF232323),
                  //           fontFamily: 'OpenSans',
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w700,
                  //           letterSpacing: -0.14,
                            
                  //         ),
                  //       ),
                  //       Text(
                  //         updatedAt,
                  //         style: const TextStyle(
                  //           color: Color(0xFF232323),
                  //           fontFamily: 'Manrope',
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w400,
                  //           letterSpacing: 0.24,
                  //           height: 1.6,
                            
                  //         ).copyWith(
                  //           color: const Color(0xFF232323).withOpacity(0.7),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                
                  ],
              ),
              Text(
                commentLikes,
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
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [

                    // upvote icon 
                    SizedBox(
                      height: 25,
                      child: Image.asset('assets/images/icons/chevron-double-up.png'),
                    ),
                    SizedBox(width: 10,),
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
                    SizedBox(width: 10,),
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
