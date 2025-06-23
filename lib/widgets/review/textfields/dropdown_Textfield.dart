import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/form_Controller.dart';

class DropdownTextfieldWidget extends StatelessWidget {

  final RxList<String> textFieldList;
  final SingleValueDropDownController textFieldCtrl;
  final String hintText;
  final RxString selectedTextField;

 DropdownTextfieldWidget({ Key? key, required this.textFieldList, required this.textFieldCtrl, required this.hintText, required this.selectedTextField }) : super(key: key);


 
final formController = Get.find<FormController>();

final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade500),
    borderRadius: BorderRadius.circular(15),
  );

  @override
  Widget build(BuildContext context){
    return Obx(() => Container(
                  height: 50,
                  child: DropDownTextField(
                    controller: textFieldCtrl,
                    clearOption: true,
                    readOnly: true,
                    enableSearch: true,

                    clearIconProperty: IconProperty(color: Colors.grey),
                    // searchTextStyle: TextStyle(color: Color.fromARGB(255, 54, 127, 244)),
                    // searchDecoration: InputDecoration(hintText: "  Airport"),

                    dropDownItemCount: textFieldList.length,
                    dropDownList: textFieldList
                        .map(
                          (value) =>
                              DropDownValueModel(name: value, value: value),
                        )
                        .toList(),
                    textFieldDecoration: InputDecoration(
                      hintText: hintText,
                      border: outlineBorder,
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      contentPadding: const EdgeInsets.only(left: 22),
                      enabledBorder: outlineBorder,
                      focusedBorder: outlineBorder,
                    ),
                    onChanged: (val) {
                      if (val is DropDownValueModel) {
                        selectedTextField.value =
                                val.value;
                      }
                    },
                  ),
                ))
            
            ;
  }
}