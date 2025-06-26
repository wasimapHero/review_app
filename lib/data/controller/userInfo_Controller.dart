import 'dart:developer';
import 'dart:io';

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
  final newUserInfo = UserInfo.empty().obs;

  var showUserIcon = true.obs;

  final picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString uploadedUrl = ''.obs;

  // pick Image and put path value
  // from camera
  Future<void> pickSingleImageCamera() async {
  try {
    // Clear old references before starting
    selectedImage.value = null;
    showUserIcon.value = true;

    // Pick image from camera
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    // Check if something was picked
    if (pickedFile != null && pickedFile.path.isNotEmpty) {
      final imageFile = File(pickedFile.path);

      // Ensure the file exists
      final fileExists = await imageFile.exists();
      if (fileExists) {
        selectedImage.value = imageFile;
        showUserIcon.value = false;

        log('✅ Picked image path: ${imageFile.path}');
      } else {
        log('⚠️ Picked file does not exist on the filesystem: ${pickedFile.path}');
      }
    } else {
      log('⚠️ No image picked from camera.');
    }
  } catch (e, stackTrace) {
    log('❌ Camera image pick failed: $e');
    log('📌 Stack trace: $stackTrace');
  }
}


  // from gallery
  Future<void> pickSingleImageGallery() async {
   try {
    // Clear old references before starting
    selectedImage.value = null;
    showUserIcon.value = true;

    // Pick image from camera
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // Check if something was picked
    if (pickedFile != null && pickedFile.path.isNotEmpty) {
      final imageFile = File(pickedFile.path);

      // Ensure the file exists
      final fileExists = await imageFile.exists();
      if (fileExists) {
        selectedImage.value = imageFile;
        showUserIcon.value = false;

        log('✅ Picked image path: ${imageFile.path}');
      } else {
        log('⚠️ Picked file does not exist on the filesystem: ${pickedFile.path}');
      }
    } else {
      log('⚠️ No image picked from camera.');
    }
  } catch (e, stackTrace) {
    log('❌ Camera image pick failed: $e');
    log('📌 Stack trace: $stackTrace');
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
      // clear selected path
      selectedImage.value = null;
    } catch (e) {
      Get.snackbar('Upload failed', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> insertUserInfoToDB(FeedController feedController) async {
    try {
      final response = await Supabase.instance.client
          .from('user_info')
          .insert({
            'user_id': user!.id,
            'email': user!.email,
            'user_name': myAccountController.editedUserName.value,
            'about': myAccountController.editedAbout.value,
            'user_image': uploadedUrl.value,
            'created_at': user!.createdAt,
            'last_active': user!.lastSignInAt!,
          })
          .select()
          .single();

      newUserInfo.value = UserInfo.fromJson(response);
      log('added userIfo: $newUserInfo');

      Get.snackbar('Success', 'user info added successfully',
          snackPosition: SnackPosition.BOTTOM);

      //
      // feedController.fetchedReviews();
      Get.find<UserinfofetchController>().refresh();
      Get.find<FeedController>().refresh();
      Future.delayed(Duration(milliseconds: 1000), () => Get.offAllNamed(TRouteNames.feedPage));
      
      update();

      // empty selected image
      selectedImage.value = null;

    } catch (e) {
      Get.snackbar('Failed to add user_info:', '  $e',
          snackPosition: SnackPosition.BOTTOM);
      log('$e');
    }
  }

  Future<void> updateUserInfoInDB(String userId) async {
    try {
      await Supabase.instance.client.from('user_info').update({
        'user_name': myAccountController.editedUserName.value,
        'about': myAccountController.editedAbout.value,
        'user_image': uploadedUrl.value,
      }).eq('user_id', userId); // update only the matching user

      Get.snackbar(
        'Success',
        'User info updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.find<FeedController>().refresh();
      Get.find<UserinfofetchController>().refresh();
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
