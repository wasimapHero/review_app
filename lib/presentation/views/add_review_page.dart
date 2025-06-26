import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/services/airport_Controller.dart';
import 'package:review_app/data/controller/airport_dropdown_Controller.dart';
import 'package:review_app/data/controller/airport_dropdown_ControllerArrival.dart';
import 'package:review_app/data/controller/feed_Controller.dart';
import 'package:review_app/data/controller/form_Controller.dart';
import 'package:review_app/data/controller/image_upload_Controller.dart';
import 'package:review_app/presentation/widgets/review/errorText/errorText.dart';
import 'package:review_app/presentation/widgets/review/image_receiver.dart';
import 'package:review_app/presentation/widgets/review/rating.dart';
import 'package:review_app/presentation/widgets/review/submit_Button.dart';
import 'package:review_app/presentation/widgets/review/textfields/dropdown_Textfield.dart';
import 'package:review_app/presentation/widgets/review/textfields/searchableItem_dropDownArrival.dart';
import 'package:review_app/presentation/widgets/review/textfields/searchableItem_dropDownDeparture.dart';
import 'package:review_app/presentation/widgets/review/textfields/travelDate_Textfield.dart';

class AddReviewPage extends StatelessWidget {
  final formController = Get.find<FormController>();
  final imageUploadController = Get.find<ImageUploadController>();
  final feedController = Get.find<FeedController>();
  final  dropdownController = Get.find<AirportDropdownController>();
  final  dropdownControllerArrival = Get.find<AirportDropdownControllerArrival>();
  final  airportController = Get.find<AirportController>();

  AddReviewPage({super.key});

  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade500),
    borderRadius: BorderRadius.circular(15),
  );

  @override
  Widget build(BuildContext context) {


      // Load data into dropdown controller
    dropdownController.setAirportList(airportController.airportList.value);
    dropdownControllerArrival.setAirportList(airportController.airportList.value);

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
            // DropdownTextfieldWidget(
            //     textFieldList: [{}],
            //     textFieldCtrl: formController.singleValueDropDownController1,
            //     hintText: 'Departure Airport',
            //     selectedTextField: formController.selectedDeparture),
            SearchableAirportDropdownDeparture(
            onChanged: (iata) {
              print("Selected IATA: $iata");
            }, 
          ),
            // Error Text
            ErrorText(errorText: formController.departureError),
            const SizedBox(height: 10),

            // ---------- Arrival Airport
           SearchableAirportDropdownArrival(onChanged: (iata) {
              print("Selected IATA: $iata");
            }),
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

            // ------------- Review input box
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
            SubmitButton(selectedArrival: dropdownControllerArrival.selectedArrival.value, 
            selectedDeparture: dropdownController.selectedDeparture.value,)
          ],
        ),
      ),
    );
  }
}
