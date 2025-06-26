import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/app/routes/app_routes.dart';
import 'package:review_app/data/controller/auth_Controller.dart';

class RouteMiddleware extends GetMiddleware {

  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    

    return authController.isAutheticated! ? null : RouteSettings(name: TRouteNames.loginScreen) ;
  }
}