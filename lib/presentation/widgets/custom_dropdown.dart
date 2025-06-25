// custom_dropdown_search.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/dropdown_search_Controller.dart';

class CustomDropdownSearch extends StatelessWidget {
  final DropdownSearchController controller;
  final String hintText;
  final TextStyle? itemStyle;
  final Color? dropdownBackgroundColor;
  final Color? dropdownBorderColor;
  
  final Color? itemBackgroundColor;
  final Color? itemHoverColor;
  final Color? itemFocusColor;


  const CustomDropdownSearch({
    Key? key,
    required this.controller,
    this.hintText = 'Search or select',
    this.itemStyle,
    this.itemBackgroundColor,
    this.dropdownBackgroundColor,
    this.dropdownBorderColor,
    this.itemHoverColor,
    this.itemFocusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller.textController,
          focusNode: controller.focusNode,
          onChanged: controller.onTextChanged,
          onTap: () => controller.showDropdown.value = true,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                if (controller.textController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear, size: 18),
                    onPressed: controller.clearInput,
                  ),
                IconButton(
                  icon: const Icon(Icons.arrow_drop_down),
                  onPressed: controller.toggleDropdown,
                ),
              ],
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: dropdownBorderColor ?? Colors.grey,
              ),
            ),
          ),
        ),
        Obx(() => controller.showDropdown.value
            ? Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: dropdownBackgroundColor ?? Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredItems[index];

                    // ------item individual
                    return Container(
                  decoration: BoxDecoration(
                  color: itemBackgroundColor ?? Colors.white,
                  border: Border.all(style: BorderStyle.none),
                ),
                      child: ListTile(
                        hoverColor: itemHoverColor ?? Colors.white,
                        focusColor: itemFocusColor ?? Colors.white,
                        title: Text(item, style: itemStyle),
                        onTap: () => controller.selectItem(item),
                      ),
                    );
                  },
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }
}
