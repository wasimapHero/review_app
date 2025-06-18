import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/review.dart';

class FeedController extends GetxController {
  final reviews = <Review>[].obs;  // Review class pattern er datar list
  final commentControllers = <int, TextEditingController>{};
  final replyControllers = <int, TextEditingController>{};

  final supabase = Supabase.instance.client;

  @override
  void onInit() {
    fetchReviews();
    super.onInit();
  }
  /// -------------fetch reviews in feed
  Future<void> fetchReviews() async {
  final response = await Supabase.instance.client
      .from('reviews')
      .select()
      .order('created_at', ascending: false);

  // Ensure the response is a list of maps
  if (response.isNotEmpty) {
    reviews.value = response.map((json) => Review.fromJson(json)).toList();
  } else {
    print("Error: Unexpected response format: $response");
    reviews.value = [];
  }
}

  


  // ---------delete Review
  Future<void> deleteReview(int reviewId) async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return;

  final response = await Supabase.instance.client
      .from('reviews')
      .delete()
      .eq('id', reviewId)
      .eq('user_id', user.id); // Ensure users can only delete their own reviews

  if (response.error != null) {
    print("Delete failed: ${response.error!.message}");
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
    print("Update failed: ${response.error!.message}");
  } else {
    await fetchReviews(); // Refresh list after update
  }
}


  /// -------------Comment methods in feed

  
}