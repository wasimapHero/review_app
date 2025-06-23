import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/imageInfo_COntroller.dart';

class PhotoGalleryController extends GetxController {
  /// The list of image URLs
  final imgs = <String>[].obs;
  var imgsHeight = 0.0;
  final List<int> imgsHeightList = [];
  var sumOfPreviousHeights = 0;

  final imageInfoController = Get.find<ImageInfoController>();

  /// ScrollController for the ListView
  late final ScrollController scrollController;

  /// Called once to initialize the images and jump to the tapped index
  void init(List<String> images, int startIndex,double screenHeight, BuildContext ctx) {
    imgs.assignAll(images);
    scrollController = ScrollController();

    // After first frame, calculate offset and jump
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      
      // each item’s total height = remaining screen + 2*5px padding

      for (var imageUrl in imgs) {
        final imageHeight = await imageInfoController.getImageHeight(imageUrl);
        imgsHeightList.add(imageHeight + 10);
      }
      print('imgsHeightList: ${imgsHeightList}');
      //
      for (int i = 0; i < imgsHeightList.length; i++) {
        sumOfPreviousHeights += imgsHeightList[i];

        if (i == startIndex) {
          // scrollController.jumpTo(sumOfPreviousHeights.toDouble());
          print('jumping to $sumOfPreviousHeights height');
          print('screenheight $screenHeight height');
          break; // ✅ Stop iterating after jump
        }
      }
      final offset = kToolbarHeight+ 350* startIndex + 2*15;
      scrollController.jumpTo(offset);

      // print(sums); // → [0, 2, 42, 68, 113, 180, 225]
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
