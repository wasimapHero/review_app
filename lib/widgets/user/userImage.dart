import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/userInfoFetch_Controller.dart';

class UserImage extends StatelessWidget {
 UserImage({ Key? key }) : super(key: key);

 final userInfoFetchController = Get.find<UserinfofetchController>();

  @override
  Widget build(BuildContext context){
    return Obx(
                            () => ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(Get.height * 0.09),
                              child: CachedNetworkImage(
                                width: Get.height * .18,
                                height: Get.height * .18,
                                fit: BoxFit.cover,
                                imageUrl: userInfoFetchController
                                    .fetchedUserImage
                                    .value, // fetched Image url    // ------- show image if user image  available
                                errorWidget: (context, url, error) =>
                                    Icon(CupertinoIcons.person),
                              ),
                            ),
                          );
  }
}