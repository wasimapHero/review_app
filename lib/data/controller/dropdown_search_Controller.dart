// dropdown_search_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownSearchController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final RxList<String> items = <String>[].obs;
  final RxList<String> filteredItems = <String>[].obs;
  final RxBool showDropdown = false.obs;

  void setItems(List<String> newItems) {
    items.assignAll(newItems);
    filteredItems.assignAll(newItems);
  }

  void onTextChanged(String value) {
    filteredItems.assignAll(
      items.where((item) => item.toLowerCase().contains(value.toLowerCase())),
    );
  }

  void clearInput() {
    textController.clear();
    onTextChanged('');
  }

  void toggleDropdown() {
    showDropdown.value = !showDropdown.value;
  }

  void selectItem(String value) {
    textController.text = value;
    showDropdown.value = false;
  }

  @override
  void onClose() {
    textController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
