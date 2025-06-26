import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/auth_Controller.dart';
import 'package:review_app/data/controller/feed_Controller.dart';
import 'package:review_app/data/controller/form_Controller.dart';
import 'package:review_app/data/controller/myAccount_Controller.dart';
import 'package:review_app/data/controller/userInfoFetch_Controller.dart';
import 'package:review_app/data/controller/userInfo_Controller.dart';
import 'package:review_app/core/utils/format_date.dart';
import 'package:review_app/presentation/widgets/user/userImage.dart';
import 'package:review_app/presentation/widgets/user/userImageEditButton.dart';
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

                  // ------------------------------------------- body
                  Stack(children: [
                    // ------------------user Image
                    userInfoFetchController.fetchedUserImage.value.isEmpty && userInfoController.selectedImage.value!=null
                        ? Obx(() => ClipRRect(
                            borderRadius:
                                BorderRadius.circular(mq.height * 0.09),
                            child:
                                showImageInUI())) // ------- mock image if user image not available
                        : UserImage(),

                    // -----------------------User Image edit button
                    UserImageEditButton(),
                  ]),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * 0.03,
                  ),

                  // ------------------------------ show user email
                  Text(
                    userInfoController.user?.email ?? 'No email found',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * 0.05,
                  ),

                  // ------------------------------ User Name TextField
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

                  // ------------------------------ User About TextField
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

                  // ------------------------------ User Joined at text
                  Row(
                    children: [
                      Text(
                        "Joined at: ",
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                      Text(
                        userInfoController.user?.createdAt != null
                            ? FormateDateAndTime.getMonthYear(
                                userInfoController.user!.createdAt)
                            : "Joined date not available",
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * 0.07,
                  ),

                  // ------------------------------------ Update Button
                  ElevatedButton.icon(
                    onPressed: _updateButon(),
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

        // --------------------------- logout button
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              //to show dialog of progress bar
              await authController.signOutUser();
            },
            // child: Icon(Icons.add_comment_rounded)
            child: Icon(Icons.logout)),
      ),
    );
  }

  Widget showImageInUI() {
    if (userInfoController.showUserIcon.value == true) {
      return Image.asset('assets/images/user/user.png');
    } else {
      final imageFile = userInfoController.selectedImage.value;
      return imageFile != null && imageFile.existsSync()
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

  _updateButon() {
    return () async {
      if (_formKey2.currentState!.validate()) {
        _formKey2.currentState!.save();
        log('validator worked.');
        // put the text form field value in args
        myAccountController.putCtrlValue();

        // upload picked image
        if (userInfoController.selectedImage.value != null) {
          await userInfoController
              .uploadUserImage(userInfoController.selectedImage.value!);
        }

        final currentUser = Supabase.instance.client.auth.currentUser;

        if (currentUser == null) {
          log("No authenticated user found.");
          Get.snackbar(
              "Error", "You must be signed in to update your profile.");
          return;
        }

        final exists = userInfoController.newUserInfo.value.userId.isNotEmpty;
        if (exists) {
          // user_info row is already in the table
          await userInfoController.updateUserInfoInDB(
              Supabase.instance.client.auth.currentUser!.id);
        } else {
          // insert user Info
          final feedCtrl = Get.find<FeedController>();
          await userInfoController.insertUserInfoToDB(feedCtrl);
        }
        // -- end code
      }
    };
  }
}
