import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/models/airport.dart';

class AirportDropdownControllerArrival extends GetxController {
  // Complete list of airports
  var allAirports = <AirportModel>[].obs;
  
  var isPopupVisible = false.obs;
  final FocusNode focusNode = FocusNode();

  // Currently filtered airports shown in dropdown
  var filteredAirports = <AirportModel>[].obs;

  // Currently selected airport IATA code
  var selectedIata = ''.obs;
  var selectedArrival = ''.obs;
  
  var selectedArrivalAirport = AirportModel.empty().obs;

  var searchText = ''.obs;


  void hidePopup() {
    focusNode.unfocus();
    isPopupVisible.value = false;
  }

  

  @override
  void onInit() {
    super.onInit();

    // Debounce searchText changes for 500ms
    debounce(searchText, (val) {
      final trimmed = val.trim();
      if (trimmed.isNotEmpty) {
        filterAirports(trimmed);
      } else {
        filteredAirports.clear();
      }
    }, time: Duration(milliseconds: 500));

    focusNode.addListener(() {
      isPopupVisible.value = focusNode.hasFocus;
    });
  }
  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }

  

  /// Set the full list of airports and initialize filtered list
  void setAirportList(List<AirportModel> airports) {
    allAirports.value = airports;
    filteredAirports.value = airports;
  }

  /// Filter airports by query string (case-insensitive)
  void filterAirports(String query) {
    final q = query.trim().toLowerCase();
    if (q.isNotEmpty) {
      // set filteredAirports.value
      filteredAirports.value = allAirports.where((airport) {
        final name = airport.name.toLowerCase();
        final city = airport.locality!.toLowerCase();
        final country = airport.country!.toLowerCase();
        final iata = airport.iata.toLowerCase();

        return name.contains(q) ||
            city.contains(q) ||
            country.contains(q) ||
            iata.startsWith(q);
      }).toList();
    }
  }

  /// Set the selected airport's IATA code
  void selectAirport(AirportModel airport) {
    selectedIata.value = airport.iata;
  }

  /// Clear the current selection
  void clearSelection() {
    selectedIata.value = '';
  }
}
