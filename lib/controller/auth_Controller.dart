import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  var isLoading = false.obs;

  Future<void> signUp(String email, String password) async {
    isLoading.value = true;
    final res = await supabase.auth.signUp(email: email, password: password);
    isLoading.value = false;

    if (res.user != null) {
      Get.snackbar("Success", "Confirmation email sent.");
    } else {
      Get.snackbar("Error", "Signup failed");
    }
  }

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    final res = await supabase.auth.signInWithPassword(email: email, password: password);
    isLoading.value = false;

    if (res.session != null) {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Error", "Login failed");
    }
  }

  void signOut() async {
    await supabase.auth.signOut();
    Get.offAllNamed('/login');
  }

  String? get userId => supabase.auth.currentUser?.id;
}
