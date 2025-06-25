import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/form_Controller.dart';

class Rating extends StatelessWidget {
 Rating({ Key? key }) : super(key: key);

 final formController = Get.find<FormController>();

  @override
  Widget build(BuildContext context){
    return Container(
              width: Get.width * 0.7,
              child: Obx(() => Row(
                    children: [
                      Text(
                        "Rating",
                        style: TextStyle(
                            color: Colors.grey.shade400, fontSize: 15),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Container(
                            margin: EdgeInsets.only(right: 3),
                            child: SizedBox(
                              width: 18,
                              child: GestureDetector(
                                child: Icon(
                                  index < formController.rating.value
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Color(0xFFD8A31C),
                                ),
                                onTap: () {
                                  formController.rating.value = index + 1;
                                },
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  )),
            );
  }
}