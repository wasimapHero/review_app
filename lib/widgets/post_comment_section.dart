import 'package:flutter/material.dart';

class PostCommentSection extends StatelessWidget {
 PostCommentSection({ Key? key }) : super(key: key);


final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade500),
    borderRadius: BorderRadius.circular(15),
  );

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: [

              // Commentor user Id Icon
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(132),
                    child: Image.asset(
                      'assets/images/user/user.png',
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Comment Input
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F8),
                        borderRadius: BorderRadius.circular(17.335),
                        border: Border.fromBorderSide(BorderSide(color: Colors.grey.shade500),)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded( 
                            child: TextFormField(
                              controller: TextEditingController(),
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(borderSide: BorderSide.none),
                                hintText: 'write your Comment',
                                hintStyle: TextStyle(
                                color: Color(0xFF646464),
                                fontFamily: 'OpenSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.12,
                                height: 1.3,
                              ),
                              contentPadding: const EdgeInsets.only(left: 5),
                              ),
                              
                              
                            ),
                          ),

                          // send icon (for commenting)
                          Image.asset(
                            'assets/images/icons/send.png',
                            width: 29,
                            height: 29,
                            fit: BoxFit.contain,
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25,)
        ],
      ),
    );
  }
}