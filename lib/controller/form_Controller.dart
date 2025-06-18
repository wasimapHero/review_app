import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/models/comment.dart';
import 'package:review_app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/review.dart';

class FormController extends GetxController {

  final formKey = GlobalKey<FormState>();


  final departureCtrl = TextEditingController();
  final arrivalCtrl = TextEditingController();
  final airlineCtrl = TextEditingController();
  final classCtrl = TextEditingController();
  final reviewTextCtrl = TextEditingController();
  final travelDateCtrl = TextEditingController();
  final ratingCtrl = TextEditingController();
  final imageUrlsCtrl = TextEditingController();

  final ScrollController reviewScrollCtrl = ScrollController();

  final selectedDeparture = ''.obs;
  final selectedArrival = ''.obs;
  final selectedAirline = ''.obs;
  final selectedClass = ''.obs;
  final rating = 0.obs;

  final airports = <String>["CDG", "JFK", "LHR", "DXB", "HND"].obs; // sample static
  final airlines = <String>["Air France", "American Airlines", "Emirates", "Japan Airlines"].obs;

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
    departureCtrl.dispose();
    arrivalCtrl.dispose();
    airlineCtrl.dispose();
    classCtrl.dispose();
    reviewTextCtrl.dispose();
    travelDateCtrl.dispose();
    ratingCtrl.dispose();
    imageUrlsCtrl.dispose();
    reviewScrollCtrl.dispose();
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

    if (selectedDeparture.value.isEmpty) {
      departureError.value = "Select departure airport";
      valid = false;
    }
    if (selectedArrival.value.isEmpty) {
      arrivalError.value = "Select arrival airport";
      valid = false;
    }
    if (selectedAirline.value.isEmpty) {
      airlineError.value = "Select airline";
      valid = false;
    }
    if (selectedClass.value== 'Any') {
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
      final List<String> imageList = imageUrlsCtrl.text
          .split(',')
          .map((url) => url.trim())
          .where((url) => url.isNotEmpty)
          .toList();

      final reviewMap = {
        'departure_airport': selectedDeparture.value,
        'arrival_airport': selectedArrival.value,
        'airline': selectedAirline.value,
        'class': selectedClass.value,
        'review_text': reviewTextCtrl.text.trim(),
        'travel_date': travelDateCtrl.text.trim(),
        'rating': rating.value,
        'images': imageList,
      };

      final response = await Supabase.instance.client
          .from('reviews')
          .insert(reviewMap)
          .select()
          .single();

      final newReview = Review.fromJson(response);
      reviewData.add(newReview);

     


      Get.snackbar('Success', 'Review added successfully', snackPosition: SnackPosition.BOTTOM);
      clearForm();
      Get.back();
      Get.offAndToNamed(TRouteNames.feedPage);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add review: \ $e', snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
      print("All fields valid, submitting review");
    }


    
  }

  void clearForm() {
    selectedDeparture.value = '';
    selectedArrival.value = '';
    selectedAirline.value = '';
    selectedClass.value = '';
    rating.value = 0;

    reviewTextCtrl.clear();
    travelDateCtrl.clear();
    imageUrlsCtrl.clear();
  }
}
