import 'package:get/get.dart';
import 'package:review_app/controller/feed_Controller.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FeedController>( FeedController());
  }
}
