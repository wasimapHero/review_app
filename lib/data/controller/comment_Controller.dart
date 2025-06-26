import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/models/comment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentController extends GetxController {
  final supabase = Supabase.instance.client;

  // final Map<String, bool> onTappedList = {};
  // final Map<String, bool> showErrorTextList = {};
  var onTapped = false.obs;
  var showErrorText = false.obs;

  final heightOfCommentCard = 0.0.obs;

  var commentList = <Comment>[].obs;
  var commentListByUserIdAndRevId = <Comment>[].obs;
  var isLoading = false.obs;
  var isExpanded = false.obs;
  var reviewIdFromReviewCard = ''.obs;


  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  // Map to hold TextEditingControllers per reviewId
  final Map<String, TextEditingController> commentControllers = {};

  // Get controller for a specific review ID
  TextEditingController getController(String reviewId) {
  // If the controller doesn't exist, create and store one
  commentControllers.putIfAbsent(reviewId, () => TextEditingController());

  // Now it's guaranteed to exist
  return commentControllers[reviewId]!;
}


  // Optional: Clear a comment after posting
  void clearComment(String reviewId) {
    commentControllers[reviewId]?.clear();
  }


  // Dispose all controllers when controller is closed
  @override
  void onClose() {
    commentControllers.forEach((_, controller) => controller.dispose());
    super.onClose();
  }

  Future<void> postCommentToDB(String reviewId, String userId, String? userName,
      String? userImage) async {
    final text = getController(reviewId).text.trim();
    try {
      final comment = Comment(
        reviewId: reviewId.trim(),
        userId: supabase.auth.currentUser!.id,
        userName: userName,
        userImage: userImage,
        parentId: null,
        content: text,
        createdAt: DateTime.now(),
      );
      final response = await supabase
          .from('comments')
          .insert(comment.toMap())
          .select()
          .single();

      if (response.isNotEmpty) {
        final newComment = Comment.fromJson(response);
        log('Comment insert success: newComment Id:  ${newComment.id}');

        // clear crtl text
        clearComment(reviewId);
        
        // false onTapped immediate after insertion of comment
        // print('onTappedList[reviewId] : ${onTappedList[reviewId]}');
        // setOnTappedFalse(reviewId);
        onTapped.value = true;
        

        Get.snackbar('Your post is posted!', '',
            snackPosition: SnackPosition.BOTTOM);
      }
    } on PostgrestException catch (e) {
      log(' Error : ${e.message}');
      Get.snackbar('Failed to post comment to DB', ' Error : $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> fetchComments(String reviewId) async {
    try {
      isLoading.value = true;

      final response = await supabase
          .from('comments')
          .select()
          .eq('review_id', reviewId)
          .order('created_at', ascending: true);

      commentList.assignAll(
          (response as List).map((e) => Comment.fromJson(e)).toList());
    } catch (e) {
      Get.snackbar("Error", "Failed to load comments");
      log('fetchComments error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCommentsByUserIdAndReviewId(
      String userId, String reviewId) async {

        print("Fetching comments for user: $userId and review: $reviewId");

    try {
      if(userId.isNotEmpty && reviewId.isNotEmpty){
        final response = await supabase
          .from('comments')
          .select()
          .eq('user_id', userId)
          .eq('review_id', reviewId)
          .order('created_at', ascending: false);

      commentListByUserIdAndRevId.assignAll(
          (response as List).map((e) => Comment.fromJson(e)).toList());

      if (response.isNotEmpty) {
        print('Comments from current user and of given review id:  ${response[0]}');

        Get.snackbar('${commentListByUserIdAndRevId.value[0]}', '',
            snackPosition: SnackPosition.BOTTOM);
      }
      }
      
    } on PostgrestException catch (e) {
      print('fetchCommentsByUserId error: $e');
    }
  }
}
