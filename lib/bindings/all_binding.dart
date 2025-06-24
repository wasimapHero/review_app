import 'package:get/get.dart';
import 'package:review_app/controller/comment_Controller.dart';
import 'package:review_app/controller/dropdown_search_Controller.dart';
import 'package:review_app/controller/feed_Controller.dart';
import 'package:review_app/controller/form_Controller.dart';
import 'package:review_app/controller/imageInfo_COntroller.dart';
import 'package:review_app/controller/image_upload_Controller.dart';
import 'package:review_app/controller/myAccount_Controller.dart';
import 'package:review_app/controller/photoGallery_Controller.dart';
import 'package:review_app/controller/userInfoFetch_Controller.dart';
import 'package:review_app/controller/userInfo_Controller.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
// Register in the order of dependency:
    // 1) The fetcher (no dependencies of its own)
    Get.lazyPut<MyAccountController>(
      () => MyAccountController(),
      fenix: true,
    );
    Get.lazyPut<UserinfoController>(
      () => UserinfoController(),
      fenix: true,
    );

    // 2) The "holder" controller that needs the fetcher

    Get.lazyPut<UserinfofetchController>(
      () => UserinfofetchController(),
      fenix: true,
    );
    // 3) Other controllers that might need the above
    Get.lazyPut<FeedController>(
      () => FeedController(),
      fenix: true,
    );

    Get.lazyPut<FormController>(
      () => FormController(),
      fenix: true,
    );

    Get.lazyPut<DropdownSearchController>(
      () => DropdownSearchController(),
      fenix: true,
    );

    Get.lazyPut<ImageUploadController>(
      () => ImageUploadController(),
      fenix: true,
    );

    Get.lazyPut<ImageInfoController>(
      () => ImageInfoController(),
      fenix: true,
    );

    Get.lazyPut<PhotoGalleryController>(
      () => PhotoGalleryController(),
      fenix: true,
    );

    Get.lazyPut<CommentController>(
      () => CommentController(),
      fenix: true,
    );

  }
}
