import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:review_app/app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  var isSignedUp = false.obs;
  var isSignedIn = false.obs;
  var emailVerified = false.obs;

  var isLoading = false.obs;
  var hiddenPass = true.obs;

  final connectivityResult = <ConnectivityResult>[].obs;

  final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,72}$',
  );
  final emailController = TextEditingController();
  final passController = TextEditingController();

  // validate email
  var emailError = ''.obs;
  var passError = ''.obs;

  void validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
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
    } else {
      passError.value = "";
    }
  }

  @override
  void onClose() {
    passController.dispose();
    super.onClose();
  }

  Future<void> getConnectivity() async {
    connectivityResult.value = await Connectivity().checkConnectivity();
  }

  Future<void> signUp(String email, String password) async {
    validateEmail(emailController.text);
    validatePassword(passController.text);
    log(passController.text);

    if (emailError.isNotEmpty || passError.isNotEmpty) {
      Get.snackbar('Validation Error!', '$passError, $emailError');
      return;
    }

    //
    try {
      isLoading.value = true;
      final res = await supabase.auth.signUp(email: email, password: password);
      isLoading.value = false;

      if (res.user != null) {
        // new user created
        Get.snackbar("Sign up successful.", "Confirmation email sent.");

        // update isSignedUp
        isSignedUp.value = true;
        Get.offAllNamed(TRouteNames.loginScreen);
      } else {
        Get.snackbar("Error", "This email is already in use.");
      }
    } on AuthException catch (e) {
      if (e.statusCode == '400') {
        // Email already exists
        Get.snackbar("Email Exists", "This email is already in use.",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Auth Error", e.message,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signIn(String email, String password) async {
    validateEmail(emailController.text);
    validatePassword(passController.text);

    if (emailError.isNotEmpty || passError.isNotEmpty) return;

    try {
      isLoading.value = true;

      // Check internet
      if (connectivityResult.value == ConnectivityResult.none) {
        Get.snackbar("No Internet", "Please check your connection",
            snackPosition: SnackPosition.TOP);
        isLoading.value = false;
        return;
      }

     

      // Try signing in
      final response = await supabase.auth
          .signInWithPassword(email: email, password: password);

      isLoading.value = false;

      final user = response.user;

      if (user == null) {
         
        Get.snackbar("Not Signed Up", "Please sign up first",
            snackPosition: SnackPosition.TOP);
        isLoading.value = false;
        Get.offAllNamed(TRouteNames.signup);
  
        return;
      }

      // ✅ Email not verified
      if (user.emailConfirmedAt == null) {
        emailVerified.value = false;

        Get.snackbar(
          "Email Not Verified",
          "Please verify your email before signing in.",
          snackPosition: SnackPosition.TOP,
          mainButton: TextButton(
            onPressed: () async {
              try {
                final ResendResponse resendRensponse = await supabase.auth.resend(type: OtpType.email, email: email);
                Get.snackbar("Verification Sent ${resendRensponse.messageId}",
                    "Check your inbox for the new verification email.",
                    snackPosition: SnackPosition.TOP);
              } catch (e) {
                Get.snackbar("Error", "Failed to resend verification: $e",
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: Text("Resend", style: TextStyle(color: Colors.white)),
          ),
        );
        
      } else {
        // ✅ All good
      emailVerified.value = true;
      isSignedIn.value = true;
      Get.snackbar("Success", "Signed in as ${user.email} ${isAutheticated}",
          snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed(TRouteNames.feedPage);
      }

      
    } 
    
    on AuthException catch (e) {
      isLoading.value = false;

      if (e.message == 'Invalid login credentials') {
        Get.snackbar("Login Failed", "Email or password is incorrect",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Login Failed", '${e.message}. Check your Email.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signUpUser(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      // ✅ Check if user was created
      if (response.user != null) {
        Get.snackbar("Success",
            "Sign-up successful. Check your email for verification.");
        isSignedUp.value = true;
        if (response.user?.emailConfirmedAt!=null) {
          Get.snackbar("Email Confirmed",
            " ");
            emailVerified.value = true;
        } else {
          Get.snackbar("Email not Confirmed",
            "Check your email again for verification.");
        }
      } else {
        Get.snackbar("User not created", "Sign-up failed");
        isSignedUp.value = true;
      }
    } on AuthException catch (e) {
      Get.snackbar("Sign-up Failed", e.message);
      isSignedUp.value = false;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      isSignedUp.value = false;
      Get.offAllNamed(TRouteNames.signup);
    }
  }

  Future<void> signOutUser() async {
    try {
      await Supabase.instance.client.auth.signOut();
      Get.snackbar("Signed Out", "You have been logged out successfully.");

      //  navigate to login screen
      Get.offAllNamed(TRouteNames.loginScreen);
    } catch (e) {
      Get.snackbar("Error", "Failed to sign out: ${e.toString()}");
    }
  }

  bool? get isAutheticated => isSignedIn.value;
}
