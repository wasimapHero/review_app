import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/dropdown_search_Controller.dart';
import 'package:review_app/controller/feed_Controller.dart';
import 'package:review_app/controller/form_Controller.dart';
import 'package:intl/intl.dart';
import 'package:review_app/controller/image_upload_Controller.dart';
import 'package:path/path.dart' as path;

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

    var images = imageUploadController.selectedImages;
    final limitedImages = images.length > 8 ? images.sublist(0, 8) : images;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Form(
        key: formController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ("Image URLs Box"),        //
            Obx(
              () => imageUploadController.selectedImages.isEmpty ? 
              GestureDetector(
                onTap: () {
                  // Implement file picker or drag-drop logic
                  _showBottomSheetReviewImages();
                  // Get.snackbar('title', 'message');
                  // Get.bottomSheet(Container(height: 100, color: Colors.blue,));
                  // _showAnother();
                },
                child: DottedBorder(
                  color: Colors.grey.shade300,
                  strokeWidth: 2,
                  dashPattern: [6, 3], // 6px dash, 3px gap
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: 
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.cloud_upload, size: 40),
                        Positioned(
                          bottom: 20,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Drag and drop your files here or ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                                TextSpan(
                                    text: 'browse',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ) ,
                  ),
                ),
              ) : 
              GestureDetector(
                
                onTap: () {
                  
                },
                child: DottedBorder(
                  color: Colors.grey.shade300,
                  strokeWidth: 2,
                  dashPattern: [6, 3], // 6px dash, 3px gap
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                        spacing: 14,
                        runSpacing: 8,
                        children: limitedImages.asMap().entries.map((entry) {
                          final index = entry.key;
                          final badge = entry.value;
                        
                        return IntrinsicWidth(
                            child: Container(
                              height: 25,
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.grey),
                                color: Colors.grey.shade400
                              ),
                              child:  index < imageUploadController.selectedImages.length ? Row(
                                children: [
                                  Text(path.basename(imageUploadController.selectedImages[index].path)
                                  .substring(path.basename(imageUploadController.selectedImages[index].path).length - 10) ,
                                  maxLines: null, overflow: TextOverflow.fade, softWrap: true, style: TextStyle(fontSize: 12),),
                                  SizedBox(width: 4,),
                                  InkWell(
                                    onTap: () {
                                      imageUploadController.selectedImages.removeAt(index);
                                      Get.snackbar('Image Deleted!', '${path.basename(imageUploadController.selectedImages[index].path).length - 5}', snackPosition: SnackPosition.BOTTOM);
                                      print('${path.basename(imageUploadController.selectedImages[index].path).length - 12}');
                                    },
                                    child: CircleAvatar(child: Icon(Icons.close, size: 6,),radius: 6,))
                                ],
                              ) : Container(),
                            ),
                          );
                          }).toList()
                        ,
                      ),
                    ) ,
                  ),
                ),
              )
                    ,
            ),
            const SizedBox(height: 20),

            // ---------Departure Airport
            Obx(() => Container(
                  height: 50,
                  child: DropDownTextField(
                    controller: formController.singleValueDropDownController1,
                    clearOption: true,
                    readOnly: true,
                    enableSearch: true,

                    clearIconProperty: IconProperty(color: Colors.grey),
                    // searchTextStyle: TextStyle(color: Color.fromARGB(255, 54, 127, 244)),
                    // searchDecoration: InputDecoration(hintText: "  Airport"),

                    dropDownItemCount: formController.airports.length,
                    dropDownList: formController.airports
                        .map(
                          (value) =>
                              DropDownValueModel(name: value, value: value),
                        )
                        .toList(),
                    textFieldDecoration: InputDecoration(
                      hintText: 'Departure Airport',
                      border: outlineBorder,
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      contentPadding: const EdgeInsets.only(left: 22),
                      enabledBorder: outlineBorder,
                      focusedBorder: outlineBorder,
                    ),
                    onChanged: (val) {
                      if (val is DropDownValueModel) {
                        formController.isSingleValContDisposed1.value
                            ? formController.selectedDeparture.value = ''
                            : formController.selectedDeparture.value =
                                val.value;
                      }
                    },
                  ),
                )),
            // Error Text
            Obx(() => formController.departureError.value == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 12),
                    child: Text(
                      formController.departureError.value!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )),
            const SizedBox(height: 10),

            // ----------Arrival Airport
            Obx(() => Container(
                  height: 50,
                  child: DropDownTextField(
                    controller: formController.singleValueDropDownController2,
                    clearOption: true,
                    readOnly: true, enableSearch: true,
                    clearIconProperty: IconProperty(color: Colors.grey),
                    // searchTextStyle: TextStyle(color: Color.fromARGB(255, 54, 127, 244)),
                    // searchDecoration: InputDecoration(hintText: "  Airport"),
                    dropDownItemCount: formController.airports.length,
                    dropDownList: formController.airports
                        .map(
                          (value) =>
                              DropDownValueModel(name: value, value: value),
                        )
                        .toList(),
                    textFieldDecoration: InputDecoration(
                      border: outlineBorder,
                      hintText: 'Arrival Airport',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      contentPadding: const EdgeInsets.only(left: 22),
                      enabledBorder: outlineBorder,
                      focusedBorder: outlineBorder,
                    ),
                    onChanged: (val) {
                      if (val is DropDownValueModel) {
                        formController.selectedArrival.value = val.value;
                      }
                    },
                  ),
                )),

            // Error text
            Obx(() => formController.arrivalError.value == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 12),
                    child: Text(
                      formController.arrivalError.value!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )),
            const SizedBox(height: 10),

            // const Text("Airline"),
            Obx(() => Container(
                  height: 50,
                  child: DropDownTextField(
                    controller: formController.singleValueDropDownController3,
                    clearOption: true,
                    readOnly: true, enableSearch: true,
                    clearIconProperty: IconProperty(color: Colors.grey),
                    // searchTextStyle: TextStyle(color: Color.fromARGB(255, 54, 127, 244)),
                    // searchDecoration: InputDecoration(hintText: "  Airport"),
                    dropDownItemCount: formController.airlines.length,
                    dropDownList: formController.airlines
                        .map(
                          (value) =>
                              DropDownValueModel(name: value, value: value),
                        )
                        .toList(),
                    textFieldDecoration: InputDecoration(
                      border: outlineBorder,
                      hintText: 'Airline',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      contentPadding: const EdgeInsets.only(left: 22),
                      enabledBorder: outlineBorder,
                      focusedBorder: outlineBorder,
                    ),
                    onChanged: (val) {
                      if (val is DropDownValueModel) {
                        formController.selectedAirline.value = val.value;
                      }
                    },
                  ),
                )),
            // Error Text
            Obx(() => formController.airlineError.value == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 12),
                    child: Text(
                      formController.airlineError.value!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )),
            const SizedBox(height: 10),

            // const Text("Class"),
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
            Obx(() => formController.classError.value == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 12),
                    child: Text(
                      formController.classError.value!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )),
            const SizedBox(height: 10),

            // const Text("Review"),        //
            SizedBox(
              height: 100,
              child: TextFormField(
                controller: formController.reviewTextCtrl,
                keyboardType: TextInputType.multiline,
                maxLines: null,
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

            // const Text("Travel Date (MM-YYYY)"),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: formController.travelDateCtrl,
                readOnly: true,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    formController.travelDateCtrl.text =
                        DateFormat('dd MMM yyyy').format(pickedDate);
                    formController.travelDateUItcFormat.value =
                        pickedDate.toUtc();
                    // print('Formatted Date: ${pickedDate.toUtc().toIso8601String()}'); // e.g., 2025-06-18T10:35:00.000Z
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Travel Date',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 15),
                    contentPadding: const EdgeInsets.only(left: 22),
                    suffixIcon: Icon(Icons.calendar_today),
                    border: outlineBorder),
              ),
            ),

            //  Error Text
            Obx(() => formController.travelDateError.value != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 12),
                    child: Text(
                      formController.travelDateError.value!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                : SizedBox()),
            const SizedBox(height: 10),

            // const Text("Rating"),
            Container(
              width: Get.width * 0.7,
              child: Obx(() => Row(
                    children: [
                      Text(
                        "Rating",
                        style: TextStyle(
                            color: Colors.grey.shade400, fontSize: 15),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Container(
                            margin: EdgeInsets.only(right: 3),
                            child: SizedBox(
                              width: 18,
                              child: GestureDetector(
                                child: Icon(
                                  index < formController.rating.value
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Color(0xFFD8A31C),
                                ),
                                onTap: () {
                                  formController.rating.value = index + 1;
                                },
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  )),
            ),

            // Error Text
            if (formController.ratingError.value != null)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  formController.ratingError.value!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
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
              onPressed: () async{
                if (formController.validateAll()) {
                  // fetch images just before adding the review
                  await imageUploadController.fetchReviewImages(formController.imageReviewCommonId.value);

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

  // _showBottomSheet body
   _showBottomSheetReviewImages() {
     Get.bottomSheet(Container(
      height: Get.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
      ),
      child: ListView(
        shrinkWrap: true,
        padding:
            EdgeInsets.only(top: Get.height * 0.03, bottom: Get.height * 0.05),
        children: [
          Text(
            "Pick Image",
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
                  onPressed: () async {
                    Get.back(); // close bottom sheet
                    await imageUploadController.pickMultipleImages();
       
                    if (imageUploadController.selectedImages.isNotEmpty) {
                      // generate a random int
                      final Random _random = Random();
       
                      
       
                      int generateRandomId() {
                        // Generate a random 64-bit int (up to max 9,223,372,036,854,775,807)
                        // put the random number in alreadyGeneratedRandomInt to eliminate same number later
                        final randomIntNow =
                            _random.nextInt(1 << 31) + (1 << 31);
                        if (feedController.alreadyGeneratedRandomInt.value == randomIntNow) {
                        return generateRandomId();
                      } else {
                        feedController.alreadyGeneratedRandomInt.value = randomIntNow; // save the new one
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
                  },
                  child: Image.asset("assets/images/icons/add_image.png")),
            ],
          )
        ],
           ),
     
       ));
  }
  
  void _showAnother() {
    Get.bottomSheet(Container(height: 100, color: Colors.blue,));
  }
}
