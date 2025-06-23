import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/dropdown_search_Controller.dart';
import 'package:review_app/controller/feed_Controller.dart';
import 'package:review_app/controller/form_Controller.dart';
import 'package:review_app/controller/image_upload_Controller.dart';
import 'package:review_app/widgets/review/errorText/errorText.dart';
import 'package:review_app/widgets/review/image_receiver.dart';
import 'package:review_app/widgets/review/rating.dart';
import 'package:review_app/widgets/review/textfields/dropdown_Textfield.dart';
import 'package:review_app/widgets/review/textfields/travelDate_Textfield.dart';

class AddReviewPage extends StatelessWidget {
  final formController = Get.find<FormController>();
  final dropdownController = Get.find<DropdownSearchController>();
  final imageUploadController = Get.find<ImageUploadController>();
  final feedController = Get.find<FeedController>();

  AddReviewPage({super.key});

  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade500),
    borderRadius: BorderRadius.circular(15),
  );

  @override
  Widget build(BuildContext context) {
    // set items right here
    dropdownController.setItems(['CDG', 'LHR', 'JFK', 'DXB', 'HND']);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Form(
        key: formController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------  Image URLs receiver
            ImageReceiver(),

            const SizedBox(height: 20),

            // ------------------- Departure Airport textField & its error text
            DropdownTextfieldWidget(
                textFieldList: formController.airports,
                textFieldCtrl: formController.singleValueDropDownController1,
                hintText: 'Departure Airport',
                selectedTextField: formController.selectedDeparture),
            // Error Text
            ErrorText(errorText: formController.departureError),
            const SizedBox(height: 10),

            // ---------- Arrival Airport
            DropdownTextfieldWidget(
                textFieldList: formController.airports,
                textFieldCtrl: formController.singleValueDropDownController2,
                hintText: 'Arrival Airport',
                selectedTextField: formController.selectedArrival),
            // Error Text
            ErrorText(errorText: formController.arrivalError),
            const SizedBox(height: 10),

            // ------------ Airline
            DropdownTextfieldWidget(
                textFieldList: formController.airlines,
                textFieldCtrl: formController.singleValueDropDownController3,
                hintText: 'Airline',
                selectedTextField: formController.selectedAirline),
            // Error Text
            ErrorText(errorText: formController.airlineError),
            const SizedBox(height: 10),

            // -------------- Class
            SizedBox(
              height: 50,
              child: DropdownSearch<String>(
                selectedItem: formController.selectedClass.value.isEmpty
                    ? null
                    : formController.selectedClass.value,
                items: [
                  'Any',
                  'Business',
                  'First',
                  'Premium Economy',
                  'Economy'
                ],
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  hintText: 'Class',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  contentPadding: const EdgeInsets.only(left: 22),
                  border: outlineBorder,
                  enabledBorder: outlineBorder,
                  focusedBorder: outlineBorder,
                )),
                onChanged: (value) {
                  formController.selectedClass.value = value ?? '';
                },
              ),
            ),
            // Error Text
            ErrorText(errorText: formController.classError),
            const SizedBox(height: 10),

            // ------------- Review
            SizedBox(
              height: 100,
              child: TextFormField(
                controller: formController.reviewTextCtrl,
                keyboardType: TextInputType.multiline,
                maxLines: 150,
                minLines: 3,
                scrollController: formController.reviewScrollCtrl,
                decoration: InputDecoration(
                    hintText: 'Write Description',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 15),
                    contentPadding: const EdgeInsets.only(left: 20, top: 16),
                    border: outlineBorder),
              ),
            ),

            const SizedBox(height: 10),

            // ------------ Travel Date (MM-YYYY)
           TravelDateTextfield(),
            //  Error Text
            ErrorText(errorText: formController.travelDateError),
            const SizedBox(height: 10),

            // --------------- Rating 
            Rating(),
            // Error Text
            ErrorText(errorText: formController.ratingError),
            const SizedBox(height: 10),

            // Button submit
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button background color
                  foregroundColor: Colors.white, // Text (and icon) color
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  fixedSize: Size(Get.width * 0.4, 42)),
              onPressed: () async {
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
              },
              child: Text(
                'Share Now',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }

}
