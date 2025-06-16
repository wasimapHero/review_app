import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:review_app/bindings/all_binding.dart';
import 'package:review_app/routes/app_routes.dart';
import 'package:review_app/screens/feed_page.dart';
import 'package:review_app/screens/login.dart';
import 'package:review_app/screens/signup.dart';
import 'package:review_app/screens/my_account_page.dart';
import 'package:review_app/screens/share_page.dart';
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
        GetPage(name: TRouteNames.sharePage, page: () => SharePage(),),
        GetPage(name: TRouteNames.loginScreen, page: () => LoginScreen(),),
        GetPage(name: TRouteNames.signup, page: () => SignupScreen(),),
      ],
      initialBinding: AllBinding(),
      // initialRoute: Supabase.instance.client.auth.currentSession != null ? TRouteNames.feedPage : TRouteNames.loginScreen, /
      initialRoute: TRouteNames.feedPage 
      
      
    );
  }
}