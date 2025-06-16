import 'package:flutter/material.dart';
import 'package:flutter_regex/flutter_regex.dart';
import 'package:get/get.dart';
import 'package:review_app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  var isLoading = false.obs;
  var hiddenPass = true.obs;
   final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,72}$',
  );
   final emailController = TextEditingController();
  final passController = TextEditingController();

  // validate email
  var emailError = ''.obs;
  var passError = ''.obs;

  void validateEmail(String value) {
    if (!GetUtils.isEmail(value) ) {
      emailError.value = "Enter a valid email!";
    } else {
      emailError.value = "";
    }
  }

  // validate password
  void validatePassword(String value) {
    

    if (value.isEmpty) {
      passError.value = "Password cannot be empty";
    } else if (value.length > 72) {
      passError.value = "Password cannot exceed 72 characters";
    } else if (!_passwordRegex.hasMatch(value)) {
      passError.value =
          "Must include upper, lower, number, special char (8–72 chars)";
    } 
    else {
      passError.value = "";
    }
  }
   @override
  void onClose() {
    passController.dispose();
    super.onClose();
  }



  Future<void> signUp(String email, String password) async {

    validateEmail(emailController.text);
    validatePassword(passController.text);
    print(passController.text);

    if (emailError.isNotEmpty || passError.isNotEmpty){
      Get.snackbar('Validation Error!', '$passError, $emailError');
      return;
    };

   //
    try {
      isLoading.value = true;
    final res = await supabase.auth.signUp(email: email, password: password);
    isLoading.value = false;

    if (res.user != null) {
      // new user created
      Get.snackbar("Sign up successful.", "Confirmation email sent.");
      Get.offAllNamed(TRouteNames.loginScreen);
    } else {
      Get.snackbar("Error", "This email is already in use.");
    }
    }on AuthException catch (e) {
    if (e.statusCode == '400' ) {
      // Email already exists
      Get.snackbar("Email Exists", "This email is already in use.",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Auth Error", e.message ,
          snackPosition: SnackPosition.BOTTOM);
    }
  }  catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signIn(String email, String password) async {
    validateEmail(emailController.text);
    validatePassword(passController.text);

    if (emailError.isNotEmpty || passError.isNotEmpty) return;

    //
   try {
     isLoading.value = true;
    final res = await supabase.auth.signInWithPassword(email: email, password: password);
    isLoading.value = false;

    

    if (res.session != null) {
      Get.offAllNamed(TRouteNames.feedPage);
    } else {
      Get.snackbar("Error", "Login failed");
    }
    } on AuthException catch (e) {
    if (e.statusCode == '400') {
      // Email not confirmed
      Get.snackbar("${e.message}", "Check your email",
          snackPosition: SnackPosition.BOTTOM);
          Get.offAllNamed(TRouteNames.loginScreen);
    } 
  }  catch (e) {
    Get.snackbar("Login failed", e.toString(),
        snackPosition: SnackPosition.BOTTOM);
    Get.offAllNamed(TRouteNames.signup);
  }
    
    
    
     
  }

  void signOut() async {
    await supabase.auth.signOut();
    Get.offAllNamed(TRouteNames.loginScreen);
  }

  String? get userId => supabase.auth.currentUser?.id;
}
