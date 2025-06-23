import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/userInfo_Controller.dart';

class UserImageEditButton extends StatelessWidget {
 UserImageEditButton({ Key? key }) : super(key: key);
 
 final userInfoController = Get.find<UserinfoController>();

  @override
  Widget build(BuildContext context){
    return Positioned(
                      bottom: -6,
                      right: -20,
                      child: MaterialButton(
                        onPressed: () {
                          _showBottomSheetPickUserImage();
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
                    );
  }
  
    void _showBottomSheetPickUserImage() {
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

}