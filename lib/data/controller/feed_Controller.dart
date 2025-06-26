import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:review_app/data/services/airport_Controller.dart';
import 'package:review_app/data/controller/comment_Controller.dart';
import 'package:review_app/data/controller/image_upload_Controller.dart';
import 'package:review_app/data/controller/userInfoFetch_Controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/review.dart';

class FeedController extends GetxController {
  final supabase = Supabase.instance.client;

  final imageUploadController = Get.put(ImageUploadController());
  final userInfoFetchController = Get.find<UserinfofetchController>();
  final commentController = Get.find<CommentController>();
  final airportController = Get.find<AirportController>();

  final replyControllers = <int, TextEditingController>{};

  var fetchedReviews = <Review>[].obs;

  var isExpanded = false.obs;

  var alreadyGeneratedRandomInt = 0.obs;

  var fetchedUserInfo = <String, String>{}.obs;

  var isLoadingReview = false.obs;

  //

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  @override
  void onInit() {
    super.onInit();
    initLogic();

    
  }
  void initLogic() {
    //  init tasks here
    fetchReviews();
    fetchUserInfoFromDB();
    callAirportAPI();
  }

  Future<void> callAirportAPI() async {
    await airportController.fetchAirports();
  }

 Future<void> fetchUserInfoFromDB() async {
  final user = Supabase.instance.client.auth.currentUser;

  if (user == null) {
    log('❌ No authenticated user found.');
    return;
  }

  try {
    final data = await userInfoFetchController.fetchUserInfo(user.id);
    fetchedUserInfo.assignAll(data);
    log('✅ Fetched user info: ${fetchedUserInfo.values.first}');
  } catch (e) {
    log('❌ Error fetching user info: $e');
  }
}

  Future<void> fetchReviews() async {
    try {
      isLoadingReview.value = true;
      final response = await supabase.from('reviews').select();
      isLoadingReview.value = false;

      if ( response.isNotEmpty) {
        List<Review> loadedReviews = response
            .map<Review>((reviewMap) => Review.fromJson(reviewMap))
            .toList();

        fetchedReviews.assignAll(loadedReviews);
      } else {
        isLoadingReview.value = false;
      }

      log("Fetched Reviews: ${fetchedReviews.length}");
    } catch (e) {
      log("Error fetching reviews: $e");
      Get.snackbar("Error", "Failed to fetch reviews");
    }
  }

  // Future

  // ---------delete Review
  Future<void> deleteReview(int reviewId) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final response = await Supabase.instance.client
        .from('reviews')
        .delete()
        .eq('id', reviewId)
        .eq('user_id',
            user.id); // Ensure users can only delete their own reviews

    if (response.error != null) {
      log("Delete failed: ${response.error!.message}");
    } else {
      await fetchReviews(); // Refresh the list after deletion
    }
  }

  // --------update Review
  Future<void> updateReview({
    required int reviewId,
    required String departureAirport,
    required String arrivalAirport,
    required String airline,
    required String travelClass,
    String? reviewText,
    required String travelDate,
    required int rating,
    List<String>? images,
  }) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final updateData = {
      'departure_airport': departureAirport,
      'arrival_airport': arrivalAirport,
      'airline': airline,
      'class': travelClass,
      'review_text': reviewText,
      'travel_date': travelDate,
      'rating': rating,
      'images': images ?? [],
    };

    final response = await Supabase.instance.client
        .from('reviews')
        .update(updateData)
        .eq('id', reviewId)
        .eq('user_id', user.id); // Ensure user can only update their own review

    if (response.error != null) {
      log("Update failed: ${response.error!.message}");
    } else {
      await fetchReviews(); // Refresh list after update
    }
  }

  /// -------------Comment methods in feed
}
