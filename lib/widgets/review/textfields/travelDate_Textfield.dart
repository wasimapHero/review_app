import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:review_app/controller/form_Controller.dart';

class TravelDateTextfield extends StatelessWidget {
  
 TravelDateTextfield({ Key? key }) : super(key: key);

 final formController = Get.find<FormController>();
 
  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade500),
    borderRadius: BorderRadius.circular(15),
  );

  @override
  Widget build(BuildContext context){
    return SizedBox(
              height: 50,
              child: TextFormField(
                controller: formController.travelDateCtrl,
                readOnly: true,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    formController.travelDateCtrl.text =
                        DateFormat('dd MMM yyyy').format(pickedDate);
                    formController.travelDateUItcFormat.value =
                        pickedDate.toUtc();
                    // print('Formatted Date: ${pickedDate.toUtc().toIso8601String()}'); // e.g., 2025-06-18T10:35:00.000Z
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Travel Date',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 15),
                    contentPadding: const EdgeInsets.only(left: 22),
                    suffixIcon: Icon(Icons.calendar_today),
                    border: outlineBorder),
              ),
            );
  }
}