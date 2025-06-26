import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/image_upload_Controller.dart';
import 'package:path/path.dart' as path;

class ImageTakenDottedBox extends StatelessWidget {
 ImageTakenDottedBox({ Key? key }) : super(key: key);

final imageUploadController = Get.find<ImageUploadController>();



  @override
  Widget build(BuildContext context){
    var images = imageUploadController.selectedImages;
    final limitedImages = images.length > 8 ? images.sublist(0, 8) : images;

    return DottedBorder(
                  color: Colors.grey.shade300,
                  strokeWidth: 2,
                  dashPattern: [6, 3], // 6px dash, 3px gap
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                        spacing: 14,
                        runSpacing: 8,
                        children: limitedImages.asMap().entries.map((entry) {
                          final index = entry.key;
                          // final badge = entry.value;
                        
                        return IntrinsicWidth(
                            child: Container(
                              height: 25,
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.grey),
                                color: Colors.grey.shade400
                              ),
                              child:  index < imageUploadController.selectedImages.length ? Row(
                                children: [
                                  Text(path.basename(imageUploadController.selectedImages[index].path)
                                  .substring(path.basename(imageUploadController.selectedImages[index].path).length - 10) ,
                                  maxLines: null, overflow: TextOverflow.fade, softWrap: true, style: TextStyle(fontSize: 12),),
                                  SizedBox(width: 4,),
                                  InkWell(
                                    onTap: () {
                                      imageUploadController.selectedImages.removeAt(index);
                                      Get.snackbar('Image Deleted!', '${path.basename(imageUploadController.selectedImages[index].path).length - 5}', snackPosition: SnackPosition.BOTTOM);
                                      log('${path.basename(imageUploadController.selectedImages[index].path).length - 12}');
                                    },
                                    child: CircleAvatar(child: Icon(Icons.close, size: 6,),radius: 6,))
                                ],
                              ) : Container(),
                            ),
                          );
                          }).toList()
                        ,
                      ),
                    ) ,
                  ),
                )
              ;
  }
}