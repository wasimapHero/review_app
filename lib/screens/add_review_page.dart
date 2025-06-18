import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/form_Controller.dart';
import 'package:intl/intl.dart';

class AddReviewPage extends StatelessWidget {
  final FormController formController = Get.put(FormController());

  AddReviewPage({super.key});

  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade500),
    borderRadius: BorderRadius.circular(15),
  );

  @override
  Widget build(BuildContext context) {

    
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
      child: Form(
        key: formController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ("Image URLs Box"),        //
            GestureDetector(
              onTap: () {
                // Implement file picker or drag-drop logic
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
                  child: Stack(
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
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            //
            // Departure Airport
            Obx(() => SizedBox(
                  height: 50,
                  child: DropdownSearch<String>(
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                      fit: FlexFit.loose,
                    ),
                    selectedItem: formController.selectedDeparture.value.isEmpty
                        ? null
                        : formController.selectedDeparture.value,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      hintText: 'Departure Airport',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      contentPadding: const EdgeInsets.only(left: 22),
                      border: outlineBorder,
                      enabledBorder: outlineBorder,
                      focusedBorder: outlineBorder,
                    )),
                    items: formController.airports,
                    onChanged: (value) {
                      formController.selectedDeparture.value = value ?? '';
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
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )),
            const SizedBox(height: 10),

            // const Text("Arrival Airport"),
            Obx(() => Container(
                  height: 50,
                  child: DropdownSearch<String>(
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                      fit: FlexFit.loose,
                    ),
                    selectedItem: formController.selectedDeparture.value.isEmpty
                        ? null
                        : formController.selectedDeparture.value,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      hintText: 'Arrival Airport',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      contentPadding: const EdgeInsets.only(left: 22),
                      border: outlineBorder,
                      enabledBorder: outlineBorder,
                      focusedBorder: outlineBorder,
                    )),
                    items: formController.airports,
                    onChanged: (value) {
                      formController.selectedArrival.value = value ?? '';
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
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )),
            const SizedBox(height: 10),

            // const Text("Airline"),
            Obx(() => SizedBox(
                  height: 50,
                  child: DropdownSearch<String>(
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                      fit: FlexFit.loose,
                    ),
                    selectedItem: formController.selectedDeparture.value.isEmpty
                        ? null
                        : formController.selectedDeparture.value,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      hintText: 'Airline',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      contentPadding: const EdgeInsets.only(left: 22),
                      border: outlineBorder,
                      enabledBorder: outlineBorder,
                      focusedBorder: outlineBorder,
                    )),
                    items: formController.airlines,
                    onChanged: (value) {
                      formController.selectedAirline.value = value ?? '';
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
                      style: const TextStyle(color: Colors.red, fontSize: 12),
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
                      style: const TextStyle(color: Colors.red, fontSize: 12),
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

            // Error Text
            // if (formController.reviewError.value != null)
            //           Padding(
            //             padding: const EdgeInsets.only(top: 4.0, left: 12),
            //             child: Text(
            //               formController.reviewError.value!,
            //               style:
            //                   const TextStyle(color: Colors.red, fontSize: 12),
            //             ),
            //           ),
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
                        DateFormat('MM-yyyy').format(pickedDate);
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
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                : SizedBox()),
            const SizedBox(height: 10),

            // const Text("Rating"),
            Container(width: Get.width * 0.7,
              child: Obx(() => Row(
                    children: [
                      Text(
                        "Rating",
                        style:
                            TextStyle(color: Colors.grey.shade400, fontSize: 15),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return SizedBox( width: 22,
                            child: IconButton(
                              icon: Icon(
                                index < formController.rating.value
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Color(0xFFD8A31C),
                              ),
                              onPressed: () {
                                formController.rating.value = index + 1;
                              },
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
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const SizedBox(height: 4),

            // Button submit
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:  Colors.black, // Button background color
                foregroundColor: Colors.white, // Text (and icon) color
                padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                fixedSize: Size(Get.width* 0.4, 42)
              ),
              onPressed: () {
                if (formController.validateAll()) {
                  formController.addReview();
                } else {
                  Get.snackbar(
                    "Validation Failed",
                    "Please fill in all required fields",
                    backgroundColor: Colors.red.shade100,
                  );
                }
              },
              child:  Text(
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
