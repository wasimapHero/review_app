import 'package:get/get.dart';
import 'package:review_app/data/controller/airport_dropdown_Controller.dart';
import 'package:review_app/data/controller/airport_dropdown_ControllerArrival.dart';
import 'package:review_app/data/controller/comment_Controller.dart';
import 'package:review_app/data/controller/dropdown_search_Controller.dart';
import 'package:review_app/data/controller/feed_Controller.dart';
import 'package:review_app/data/controller/form_Controller.dart';
import 'package:review_app/data/controller/image_upload_Controller.dart';
import 'package:review_app/data/controller/myAccount_Controller.dart';
import 'package:review_app/data/controller/photoGallery_Controller.dart';
import 'package:review_app/data/controller/userInfoFetch_Controller.dart';
import 'package:review_app/data/controller/userInfo_Controller.dart';
import 'package:review_app/data/services/airport_Controller.dart';


class AllBinding extends Bindings {
  @override
  void dependencies() {
// Register in the order of dependency:
    // 1) The fetcher (no dependencies of its own)
   Get.put(MyAccountController());
   Get.put(AirportController());

  //  Get.put(AirportDropdownController());
   Get.lazyPut<AirportDropdownController>(
      () => AirportDropdownController(),
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

    Get.lazyPut<PhotoGalleryController>(
      () => PhotoGalleryController(),
      fenix: true,
    );

    Get.lazyPut<CommentController>(
      () => CommentController(),
      fenix: true,
    );



    
    Get.lazyPut<AirportDropdownControllerArrival>(
      () => AirportDropdownControllerArrival(),
      fenix: true,
    );

  }
}
