import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/routes/app_routes.dart';
import 'package:review_app/widgets/feed-page/action_button.dart';

class ActionButtonRow extends StatelessWidget {
const ActionButtonRow({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    
return Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed(TRouteNames.shareFormPopup),
                          child: SizedBox(
                            width: Get.width * 0.50,
                            child: ActionButton(
                                text: "Share your experience",
                                iconWidth: 20,
                                iconHeight: 30,
                                fontSize: 13,
                                letterSpacing: 0.26,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                icon:
                                    'assets/images/icons/share-experience.png'),
                          ),
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
                    );


  
}}