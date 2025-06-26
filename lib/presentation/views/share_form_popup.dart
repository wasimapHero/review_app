import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/form_Controller.dart';
import 'package:review_app/presentation/views/add_review_page.dart';

class ShareFormPopup extends StatelessWidget {

  final formController = Get.find<FormController>();

 ShareFormPopup({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
        onTap: () {
          // Hide dropdown if it's open
          if (formController.showSuggestions.value) {
            formController.showSuggestions.value = false;
          }
          // Unfocus text fields if any
          FocusScope.of(context).unfocus();
        },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 5), // Top vertical gap
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Padding(
                          padding: EdgeInsets.only(top: 25),
                           child: Text(
                                         'Share',
                                         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                   ),
                         ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Get.back(); // Navigates back using GetX
                          },
                        ),
                    
                      ],
                    ),
                  ),
                  
                  // const SizedBox(height: 10), // Bottom vertical gap if needed
              
                  AddReviewPage()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}