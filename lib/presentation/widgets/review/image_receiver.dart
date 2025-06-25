import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/feed_Controller.dart';
import 'package:review_app/data/controller/form_Controller.dart';
import 'package:review_app/data/controller/image_upload_Controller.dart';
import 'package:review_app/presentation/widgets/review/imageEmpty_DottedBox.dart';
import 'package:review_app/presentation/widgets/review/imageTaken_DottedBox.dart';

class ImageReceiver extends StatelessWidget {
  ImageReceiver({Key? key}) : super(key: key);

  final formController = Get.find<FormController>();
  final imageUploadController = Get.find<ImageUploadController>();
  final feedController = Get.find<FeedController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => imageUploadController.selectedImages.isEmpty
          ? GestureDetector(
              onTap: () {
                // Implement file picker or drag-drop logic
                _showBottomSheetToPickImages();
                // Get.snackbar('title', 'message');
                // Get.bottomSheet(Container(height: 100, color: Colors.blue,));
                // _showAnother();
              },
              child: ImageEmptyDottedBox(),
            )
          : GestureDetector(onTap: () {}, child: ImageTakenDottedBox()),
    );
  }

  // _showBottomSheet body
  _showBottomSheetToPickImages() {
    Get.bottomSheet(Container(
      height: Get.height * 0.3,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: ListView(
        shrinkWrap: true,
        padding:
            EdgeInsets.only(top: Get.height * 0.03, bottom: Get.height * 0.05),
        children: [
          Text(
            "Pick Images",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // take photo from gallery
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(Get.width * 0.3, Get.height * 0.15)),
                      
                  onPressed: _pickImagesFromGallery(),

                  child: Image.asset("assets/images/icons/add_image.png")),
            ],
          )
        ],
      ),
    ));
  }

  _pickImagesFromGallery() async {
    
    await imageUploadController.pickMultipleImages();

    if (imageUploadController.selectedImages.isNotEmpty) {
      // generate a random int
      final Random _random = Random();

      int generateRandomId() {
        // Generate a random 64-bit int (up to max 9,223,372,036,854,775,807)
        // put the random number in alreadyGeneratedRandomInt to eliminate same number later
        final randomIntNow = _random.nextInt(1 << 31) + (1 << 31);
        if (feedController.alreadyGeneratedRandomInt.value == randomIntNow) {
          return generateRandomId();
        } else {
          feedController.alreadyGeneratedRandomInt.value =
              randomIntNow; // save the new one
          return randomIntNow;
        }
      }

      final image_review_common_id =
          '${formController.currentUser!.id}_${generateRandomId().toString()}'; // userId
      final urls = await imageUploadController
          .uploadImagesToSupabase(image_review_common_id);
      // also store image_review_common_id   in   formController.imageReviewCommonId.value
      formController.imageReviewCommonId.value = image_review_common_id;

      // Do something with the uploaded image URLs
      print('Uploaded image URLs: $urls');

      // Optionally update a field with URLs
      // yourReviewController.imageUrls.value = urls;
    }
  }
}
