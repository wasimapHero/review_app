import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/form_Controller.dart';

class ErrorText extends StatelessWidget {

  final RxnString errorText;
 ErrorText({ Key? key, required this.errorText }) : super(key: key);

final formController = Get.find<FormController>();

  @override
  Widget build(BuildContext context){
    return // Error Text
            Obx(() => formController.departureError.value == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 12),
                    child: Text(
                      formController.departureError.value!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ));
  }
}