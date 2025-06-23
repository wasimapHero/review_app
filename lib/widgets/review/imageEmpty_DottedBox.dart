import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImageEmptyDottedBox extends StatelessWidget {
const ImageEmptyDottedBox({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
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
                    child: 
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.cloud_upload, size: 40),
                        Positioned(
                          bottom: 20,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Drag and drop your files here or ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                                TextSpan(
                                    text: 'browse',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ) ,
                  ),
                );
  }
}