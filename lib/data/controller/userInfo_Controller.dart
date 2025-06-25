import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:review_app/data/controller/feed_Controller.dart';
import 'package:review_app/data/controller/form_Controller.dart';
import 'package:review_app/data/controller/image_upload_Controller.dart';
import 'package:review_app/data/controller/myAccount_Controller.dart';
import 'package:review_app/data/controller/userInfoFetch_Controller.dart';
import 'package:review_app/data/models/user.dart';
import 'package:review_app/app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class UserinfoController extends GetxController {
  final formController = Get.put(FormController());

  final imageUploadController = Get.put(ImageUploadController());
  final feedController = Get.put(FeedController);
  final myAccountController = Get.put(MyAccountController());
  final user = Supabase.instance.client.auth.currentUser;

  var showUserIcon = true.obs;

  final picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString uploadedUrl = ''.obs;

  @override
  void onClose() {
    super.onClose();
  }

  // pick Image and put path value
  // from camera
  Future<void> pickSingleImageCamera() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        log('picked images recieved, ${pickedFile.path}');
        selectedImage.value = File(pickedFile.path);
        showUserIcon.value = false;
        log('selected image path: ${selectedImage.value!.path}');
      }
    } catch (e) {
      log('$e');
    }
  }

  // from gallery
  Future<void> pickSingleImageGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        log('picked images recieved, ${pickedFile.path}');
        selectedImage.value = File(pickedFile.path);
        showUserIcon.value = false;
        log('selected image path: ${selectedImage.value!.path}');
      }
    } catch (e) {
      log('$e');
    }
  }

  /// Upload that file into 'user-image' bucket and return its public URL
  Future<void> uploadUserImage(File file) async {
    try {
      final client = Supabase.instance.client;
      final bucket = client.storage.from('user-images');
      // give it a unique filename
      final ext = extension(file.path); // e.g. ".jpg"
      final fileName = '${const Uuid().v4()}$ext';
      // full path if you want to namespace per user:
      final userId = client.auth.currentUser!.id;
      final pathInBucket = 'profiles/$userId/$fileName';

      // read bytes and detect MIME
      final bytes = await file.readAsBytes();
      final contentType =
          lookupMimeType(file.path) ?? 'application/octet-stream';

      // upload
      await bucket.uploadBinary(
        pathInBucket,
        bytes,
        fileOptions: FileOptions(
          upsert: true,
          contentType: contentType,
        ),
      );

      // get the public URL
      final url = bucket.getPublicUrl(pathInBucket);
      uploadedUrl.value = url;
      showUserIcon.value = false;
      log('uploaded image path: ${uploadedUrl.value}');
    } catch (e) {
      Get.snackbar('Upload failed', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<void> insertUserInfoToDB(FeedController feedController) async {
    try {
      final response = await Supabase.instance.client
          .from('user_info')
          .insert({
            'user_id': user!.id,
            'email': user!.email,
            'user_name': myAccountController.editedUserName.value ,
            'about': myAccountController.editedAbout.value ,
            'user_image': uploadedUrl.value ,
            'created_at': user!.createdAt,
            'last_active': user!.lastSignInAt!,
          })
          .select()
          .single();

      final newUserInfo = UserInfo.fromJson(response);
      log('added userIfo: $newUserInfo');

      Get.snackbar('Success', 'user info added successfully',
          snackPosition: SnackPosition.BOTTOM);

          //
         await feedController.fetchedReviews();
      Get.offAllNamed(TRouteNames.feedPage);
      update();
    } catch (e) {
      Get.snackbar('Failed to add user_info:', ' \ $e',
          snackPosition: SnackPosition.BOTTOM);
      log('$e');
    }
  }

  Future<void> updateUserInfoInDB(String userId) async {
    try {
      await Supabase.instance.client.from('user_info').update({
        'user_name': myAccountController.editedUserName.value ,
        'about': myAccountController.editedAbout.value ,
        'user_image': uploadedUrl.value ,
      }).eq('user_id', userId); // update only the matching user

      Get.snackbar(
        'Success',
        'User info updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed(TRouteNames.feedPage);
      update();
    } catch (e) {
      log('Update error: $e');
      Get.snackbar(
        'Update failed',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<bool> userInfoExists(String userId) async {
    final response = await Supabase.instance.client
        .from('user_info')
        .select('*')
        .eq('user_id', userId)
        .maybeSingle(); // returns `Map<String,dynamic>?`
    return response != null; // exists if we got a row back
  }
}
