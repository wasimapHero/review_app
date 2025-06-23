import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/auth_Controller.dart';
import 'package:review_app/controller/feed_Controller.dart';
import 'package:review_app/controller/form_Controller.dart';
import 'package:review_app/controller/myAccount_Controller.dart';
import 'package:review_app/controller/userInfoFetch_Controller.dart';
import 'package:review_app/controller/userInfo_Controller.dart';
import 'package:review_app/routes/app_routes.dart';
import 'package:review_app/utils/format_date.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyAccountPage extends StatelessWidget {
  MyAccountPage({Key? key}) : super(key: key);

  final userInfoFetchController = Get.find<UserinfofetchController>();
  final userInfoController = Get.find<UserinfoController>();
  final authController = Get.find<AuthController>();
  final feedController = Get.find<FeedController>();
  final myAccountController = Get.find<MyAccountController>();

  final Map<String, String> arguments = Get.arguments ?? {};

  final formController = Get.find<FormController>();
// formkey te form er state store
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('passed argument from feed : ${arguments}');

    final mq = Get.size;
    // check if fetched user info is empty, if so, then show textfeild empty
    // otherwise show fetched data
    if (userInfoFetchController.fetchedUserAbout.value.isNotEmpty) {
      myAccountController.aboutCtrl.text =
          userInfoFetchController.fetchedUserAbout.value;
    }

    if (userInfoFetchController.fetchedUserName.value.isNotEmpty) {
      myAccountController.userNameCtrl.text =
          userInfoFetchController.fetchedUserName.value;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text("My Account Profile")),

        // body
        body: Form(
          // key set
          key: _formKey2,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    width: mq.width,
                    height: mq.height * 0.03,
                  ),
                  Stack(children: [
                    // user Image
                    userInfoFetchController.fetchedUserImage.value.isEmpty
                        ? Obx(() => ClipRRect(
                            borderRadius:
                                BorderRadius.circular(mq.height * 0.09),
                            child: showImageInUI()))
                        : Obx(
                            () => ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(mq.height * 0.09),
                              child: CachedNetworkImage(
                                width: mq.height * .18,
                                height: mq.height * .18,
                                fit: BoxFit.cover,
                                imageUrl: userInfoFetchController
                                    .fetchedUserImage
                                    .value, // fetched Image url
                                errorWidget: (context, url, error) =>
                                    Icon(CupertinoIcons.person),
                              ),
                            ),
                          ),

                    // image edit option
                    Positioned(
                      bottom: -6,
                      right: -20,
                      child: MaterialButton(
                        onPressed: () {
                          _showBottomSheetUserImage();
                          userInfoController.showUserIcon.value = false;
                        },
                        shape: CircleBorder(
                            side: BorderSide(
                                color: Color.fromARGB(255, 93, 42, 182),
                                width: 1)),
                        color: Colors.white,
                        child: Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 93, 42, 182),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * 0.03,
                  ),
                  Text(
                    userInfoController.user!.email!,
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * 0.05,
                  ),
                  TextFormField(
                    maxLength: 25,
                    controller: myAccountController.userNameCtrl,
                    decoration: InputDecoration(
                        hintText: "e.g Meena Akter",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(CupertinoIcons.person),
                        labelText: "Name"),
                  ),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * 0.03,
                  ),
                  TextFormField(
                    controller: myAccountController.aboutCtrl,
                    decoration: InputDecoration(
                        hintText: "e.g Optimistic, World Traveler..",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(CupertinoIcons.info_circle),
                        labelText: "About"),
                  ),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        "Joined at: ",
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                      Text(
                        FormateDateAndTime.getMonthYear(
                            userInfoController.user!.createdAt),
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * 0.07,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey2.currentState!.validate()) {
                        _formKey2.currentState!.save();
                        log('validator worked.');
                        // put the text form field value in args
                        myAccountController.putCtrlValue();

                        // upload picked image
                         if (userInfoController.selectedImage.value != null) {
                           await userInfoController.uploadUserImage(userInfoController.selectedImage.value!);
                         }

                        final exists = await userInfoController.userInfoExists(
                            Supabase.instance.client.auth.currentUser!.id);
                        if (exists) {
                          // user_info row is already in the table
                          await userInfoController.updateUserInfoInDB(
                              Supabase.instance.client.auth.currentUser!.id);
                        } else {
                          // insert user Info
                          final feedCtrl = Get.find<FeedController>();
                          await userInfoController
                              .insertUserInfoToDB(feedCtrl);
                        }
                        

                        //
                        // showDelayedDialog();
                      }
                    },
                    icon: Icon(Icons.edit),
                    label: Text("Update"),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: Color.fromARGB(255, 169, 122, 240),
                                width: 1.0)),
                        minimumSize: Size(mq.width * 0.4, mq.height * 0.06),
                        backgroundColor: Color.fromARGB(255, 231, 214, 244)),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              //to show dialog of progress bar
              await authController.signOut();
            },
            // child: Icon(Icons.add_comment_rounded)
            child: Icon(Icons.logout)),
      ),
    );
  }

  void _showBottomSheetUserImage() {
    Get.bottomSheet(Container(
      height: Get.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: ListView(
        shrinkWrap: true,
        padding:
            EdgeInsets.only(top: Get.height * 0.03, bottom: Get.height * 0.05),
        children: [
          Text(
            "Pick Profile Picture",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // pick from camera
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(Get.width * 0.3, Get.height * 0.15)),
                  onPressed: () async {
                    await userInfoController.pickSingleImageCamera();
                    Get.back(); // closing pop up
                  },
                  child: Image.asset("assets/images/icons/camera.png")),

              // pick from gallery
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(Get.width * 0.3, Get.height * 0.15)),
                  onPressed: () async {
                    await userInfoController.pickSingleImageGallery();
                    Get.back(); // closing pop up
                  },
                  child: Image.asset("assets/images/icons/add_image.png")),
            ],
          )
        ],
      ),
    ));
  }

  void showDelayedDialog() {
    // Show dialog automatically after screen is loaded
    Future.delayed(Duration.zero, () {
      Get.dialog(
        const AlertDialog(
          // title: Text('Auto Dialog'),
          content: SizedBox(height: 25, child: CircularProgressIndicator()),
        ),
        barrierDismissible: false,
      );

      // Close it after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (Get.isDialogOpen ?? false) {
          Get.back(); // Closes the dialog
          Get.offAllNamed(TRouteNames.feedPage);
        }
      });
    });
  }

  Widget showImageInUI() {
    if (userInfoController.showUserIcon.value == true) {
      return Image.asset('assets/images/user/user.png');
    } else {
      return userInfoController.selectedImage.value != null
          ? Container(
              width: Get.height * .18,
              height: Get.height * .18,
              child: Image.file(
                userInfoController.selectedImage.value!,
                fit: BoxFit.cover,
              ))
          : Center(
              child: Text('No image selected.'), // show path file
            );
    }
  }
}
