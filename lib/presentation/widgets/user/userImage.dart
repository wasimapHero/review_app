import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/userInfoFetch_Controller.dart';

class UserImage extends StatelessWidget {
  UserImage({Key? key}) : super(key: key);

  final userInfoFetchController = Get.find<UserinfofetchController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final imageUrl = userInfoFetchController.fetchedUserImage.value;
        final hasValidUrl = imageUrl.isNotEmpty &&
            Uri.tryParse(imageUrl)?.hasAbsolutePath == true;

        return ClipRRect(
          borderRadius: BorderRadius.circular(Get.height * 0.09),
          child: hasValidUrl
              ? CachedNetworkImage(
                  width: Get.height * 0.18,
                  height: Get.height * 0.18,
                  fit: BoxFit.cover,
                  imageUrl: imageUrl,
                  errorWidget: (context, url, error) =>
                      const Icon(CupertinoIcons.person),
                )
              : const Icon(
                  CupertinoIcons.person,
                  size: 60, // Optional size for placeholder icon
                ),
        );
      },
    );
  }
}
