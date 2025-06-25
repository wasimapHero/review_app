

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoGalleryController extends GetxController {
  /// The list of image URLs
  final imgs = <String>[].obs;
  var imgsHeight = 0.0;
  final List<int> imgsHeightList = [];
  var sumOfPreviousHeights = 0;


  /// ScrollController for the ListView
  late final ScrollController scrollController;

  /// Called once to initialize the images and jump to the tapped index
  void init(List<String> images, int startIndex,double screenHeight, BuildContext ctx) {
    imgs.assignAll(images);
    scrollController = ScrollController();

    // After first frame, calculate offset and jump
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      
      // each item’s total height = remaining screen + 2*5px padding

      
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
