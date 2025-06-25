import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/services/airport_Controller.dart';
import 'package:review_app/data/controller/airport_dropdown_Controller.dart';
import 'package:review_app/data/controller/airport_dropdown_ControllerArrival.dart';
import 'package:review_app/data/controller/feed_Controller.dart';
import 'package:review_app/data/controller/image_upload_Controller.dart';
import 'package:review_app/data/controller/userInfoFetch_Controller.dart';
import 'package:review_app/data/models/airport.dart';
import 'package:review_app/app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/review.dart';

class FormController extends GetxController {
  final currentUser = Supabase.instance.client.auth.currentUser;
  final imageUploadController = Get.put(ImageUploadController());
  final feedController = Get.put(FeedController() );
  final airportController = Get.put(AirportController() );
  final dropdownController = Get.put(AirportDropdownController() );
  final dropdownControllerArrival = Get.put(AirportDropdownControllerArrival() );

  final formKey = GlobalKey<FormState>();

  final classCtrl = TextEditingController();
  final reviewTextCtrl = TextEditingController();
  final travelDateCtrl = TextEditingController();
  final ratingCtrl = TextEditingController();

  final ScrollController reviewScrollCtrl = ScrollController();

  final travelDateUItcFormat = DateTime.now().obs;
  final selectedAirline = ''.obs;
  final selectedClass = ''.obs;
  final rating = 0.obs;

  final showSuggestions = false.obs;
  final singleValueDropDownController1 = SingleValueDropDownController();
  final singleValueDropDownController2 = SingleValueDropDownController();
  final singleValueDropDownController3 = SingleValueDropDownController();

  final selectedValue = 'Option 1'.obs;

  var airportList = <AirportModel>[].obs;

  // get airport list from api
  void getAirports() {
    airportList.value = airportController.airportList.value;
    print('airportList.value: ${airportList.value}');
  }

  final airports =
      <String>["CDG", "JFK", "LHR", "DXB", "HND"].obs; // sample static
  final airlines = <String>[
    "Air France",
    "American Airlines",
    "Emirates",
    "Japan Airlines"
  ].obs;

  final imageReviewCommonId = ''.obs;

  final reviewData = <Review>[].obs;

  // Error var
  var departureError = RxnString(null);
  var arrivalError = RxnString(null);
  var airlineError = RxnString(null);
  var classError = RxnString(null);
  var travelDateError = RxnString(null);
  var ratingError = RxnString(null);
  var reviewError = RxnString(null);

  @override
  void onInit() {
    // Add listener to scroll to bottom as user types
    reviewTextCtrl.addListener(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (reviewScrollCtrl.hasClients) {
          reviewScrollCtrl.animateTo(
            reviewScrollCtrl.position.maxScrollExtent,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
          );
        }
      });
    });

    super.onInit();
  }

  @override
  void onClose() {
    classCtrl.dispose();
    reviewTextCtrl.dispose();
    travelDateCtrl.dispose();
    ratingCtrl.dispose();
    reviewScrollCtrl.dispose();

    singleValueDropDownController1.dispose();
    singleValueDropDownController2.dispose();
    singleValueDropDownController3.dispose();
    super.onClose();
  }

  bool validateAll() {
    // Clear previous errors
    departureError.value = null;
    arrivalError.value = null;
    airlineError.value = null;
    classError.value = null;
    travelDateError.value = null;
    ratingError.value = null;
    reviewError.value = null;

    bool valid = true;

    if (dropdownController.selectedDeparture.value.isEmpty) {
      departureError.value = "Select departure airport";
      valid = false;
    }
    if (dropdownControllerArrival.selectedArrival.value.isEmpty) {
      arrivalError.value = "Select arrival airport";
      valid = false;
    }
    if (selectedAirline.value.isEmpty) {
      airlineError.value = "Select airline";
      valid = false;
    }
    if (selectedClass.value == 'Any') {
      classError.value = "Select class";
      valid = false;
    }
    if (travelDateCtrl.text.isEmpty) {
      travelDateError.value = "Select travel date";
      valid = false;
    }
    if (rating.value == 0) {
      ratingError.value = "Please rate";
      valid = false;
    }
    // if (reviewTextCtrl.text.trim().isEmpty) {
    //   reviewError.value = "Review cannot be empty";
    //   valid = false;
    // }

    return valid;
  }

  /// ----------------- Add Review to supabase
  Future<void> addReview() async {
    if (validateAll()) {
      //  logic here

      try {
        // first get fetched imageUrls from imageUploadController.fetchedImageUrls
        List<String> imageList = [];
        imageList = imageUploadController.fetchedImageUrls;

        print('fetched iMageUrls are: ${imageList.length}');
        

        final review = Review(
          userId: currentUser!.id,
          userImage: feedController.fetchedUserInfo.value['user_image'], // or provide actual image URL
          userName: feedController.fetchedUserInfo.value['user_name'], 
          imageReviewCommonId: imageReviewCommonId.value,
          createdAt: DateTime.now().toUtc(), //type: DateTime
          departureAirport: dropdownController.selectedDeparture.value,
          arrivalAirport: dropdownControllerArrival.selectedArrival.value,
          airline: selectedAirline.value,
          travelClass: selectedClass.value,
          reviewText: reviewTextCtrl.text.trim(),
          travelDate: travelDateUItcFormat.value, //type: DateTime
          rating: rating.value,
          images: imageList ?? [],
          likes: 0,
        );

        final response = await Supabase.instance.client
            .from('reviews')
            .insert(review.toJson())
            .select()
            .single(); //insert(review)   ❌ Not valid; insert expects a Map, not a Review object

        final newReview = Review.fromJson(response);
        reviewData.add(newReview);

        Get.snackbar('Success', 'Review added successfully',
            snackPosition: SnackPosition.BOTTOM);
        clearForm();
        await feedController.fetchReviews(); // reload the review data to update in UI

        Get.offAllNamed(TRouteNames.feedPage);
        update();
      } catch (e) {
        Get.snackbar('Error', 'Failed to add review: \ $e',
            snackPosition: SnackPosition.BOTTOM);
        print(e);
      }
      print("All fields valid, submitting review");
    }
  }

  void clearForm() {
    dropdownController.selectedDeparture.value = '';
    dropdownControllerArrival.selectedArrival.value = '';
    selectedAirline.value = '';
    selectedClass.value = '';
    rating.value = 0;

    reviewTextCtrl.clear();
    travelDateCtrl.clear();
    showSuggestions.value = false;
  }
}
