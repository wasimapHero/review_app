import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountController extends GetxController {
  final userNameCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();

      final editedUserName = ''.obs;
  final editedAbout = ''.obs;

@override
  void onInit() {
    super.onInit();
  }

    @override
  void onClose() {
        userNameCtrl.dispose();
    aboutCtrl.dispose();
    super.onClose();
  }
    // put passed argument's values for accountpage
  void putCtrlValue() {
    editedAbout.value = aboutCtrl.text;
    editedUserName.value = userNameCtrl.text;
  
  }

}