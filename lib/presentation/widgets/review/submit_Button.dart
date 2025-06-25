import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/form_Controller.dart';
import 'package:review_app/data/controller/image_upload_Controller.dart';

class SubmitButton extends StatelessWidget {

  final String selectedDeparture;
  final String selectedArrival;

 SubmitButton({ Key? key, required this.selectedDeparture, required this.selectedArrival }) : super(key: key);

final formController = Get.find<FormController>();
final imageUploadController = Get.find<ImageUploadController>();

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button background color
                  foregroundColor: Colors.white, // Text (and icon) color
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  fixedSize: Size(Get.width * 0.4, 42)),
              onPressed: () async {

                if(selectedArrival.contains(selectedDeparture)) {
                    Get.snackbar(
                    "Departure & Arrival airport can't be same",
                    "Please re-correct",
                    backgroundColor: Colors.red.shade100,
                  );
                  } else {
                    if (formController.validateAll()) {
                  
                  // fetch images just before adding the review
                  await imageUploadController.fetchReviewImages(
                      formController.imageReviewCommonId.value);

                  await formController.addReview();
                } else {
                  Get.snackbar(
                    "Validation Failed",
                    "Please fill in all required fields",
                    backgroundColor: Colors.red.shade100,
                  );
                }
                  }
                
              },
              child: Text(
                'Share Now',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            );
  }
}