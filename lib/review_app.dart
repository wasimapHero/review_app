import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:review_app/bindings/all_binding.dart';
import 'package:review_app/routes/app_routes.dart';
import 'package:review_app/screens/add_review_page.dart';
import 'package:review_app/screens/feed_page.dart';
import 'package:review_app/screens/login.dart';
import 'package:review_app/screens/signup.dart';
import 'package:review_app/screens/my_account_page.dart';
import 'package:review_app/screens/share_form_popup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewApp extends StatelessWidget {
const ReviewApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      title: 'Feed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      getPages: [
        GetPage(name: TRouteNames.feedPage, page: () => FeedPage(),),
        GetPage(name: TRouteNames.myAccountPage, page: () => MyAccountPage(),),
        GetPage(name: TRouteNames.addReview, page: () => AddReviewPage(),),
        GetPage(name: TRouteNames.loginScreen, page: () => LoginScreen(),),
        GetPage(name: TRouteNames.signup, page: () => SignupScreen(),),
        GetPage(name: TRouteNames.shareFormPopup, page: () => ShareFormPopup(),),
      ],
      initialBinding: AllBinding(),
      // initialRoute: Supabase.instance.client.auth.currentSession != null ? TRouteNames.feedPage : TRouteNames.loginScreen, /
      initialRoute: TRouteNames.feedPage 
      
      
    );
  }
}