import 'package:get/get.dart';
import 'package:review_app/controller/auth_Controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
