import 'dart:developer';

import 'package:get/get.dart';
import 'package:review_app/controller/myAccount_Controller.dart';
import 'package:review_app/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserinfofetchController extends GetxController {
  var fetchedUserImage = ''.obs;
  var fetchedUserName = ''.obs;
  var fetchedUserAbout = ''.obs;
  final myAccountController = Get.find<MyAccountController>();
  var fetchedUserInfoFromDB = <String, String>{}.obs;

  Future<Map<String, String>> fetchUserInfo(String userId) async {
    try {
      final response = await Supabase.instance.client
          .from('user_info')
          .select()
          .eq('user_id', userId)
          .single(); // Using `.single()` as i expect only one result
          log('response from user-info bucket: ${response}');

      if (response.isNotEmpty) {
        final data = UserInfo.fromJson(response);
        fetchedUserImage.value = data.userImage ?? '';
        fetchedUserName.value = data.userName ?? '';
        fetchedUserAbout.value = data.about ?? '';

        log("Fetched User Name: ${fetchedUserName.value}");
        log("Fetched about: ${fetchedUserAbout.value}");
        log("Fetched user Image: ${fetchedUserImage.value}");

        fetchedUserInfoFromDB.addAll({
          'user_image': fetchedUserImage.value,
          'user_name': fetchedUserName.value,
          'about': fetchedUserAbout.value,
        });
        return fetchedUserInfoFromDB;
      } else {
        return <String, String>{};
      }
    } catch (e) {
      log('Error fetching user info: $e');
    }
    return <String, String>{};
  }
}
