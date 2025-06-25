import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/airport_dropdown_Controller.dart';

class SearchableAirportDropdownDeparture extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final AirportDropdownController dropdownController =
      Get.put(AirportDropdownController());
  final void Function(String iata) onChanged;

  SearchableAirportDropdownDeparture(
      {Key? key, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: dropdownController.hidePopup,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            focusNode: dropdownController.focusNode,
            onChanged: (value) {
              dropdownController.isPopupVisible.value = true;
              dropdownController.searchText.value = value;
              dropdownController
                  .filterAirports(dropdownController.searchText.value);
            },
            onTap: () => dropdownController.isPopupVisible.value = true,
            decoration: InputDecoration(
              hintText: dropdownController.selectedDeparture.value.isNotEmpty ? '${dropdownController.selectedDepartureAirport.value.place}' : 'Search airport...',
              suffixIcon: Icon(Icons.arrow_drop_down),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          Obx(() {
            if (!dropdownController.isPopupVisible.value)
              return SizedBox.shrink();
            return Container(
              margin: const EdgeInsets.only(top: 4),
              constraints: BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
              child: ListView.builder(
                itemCount: dropdownController.filteredAirports.isEmpty
                    ? dropdownController.allAirports.length
                    : dropdownController.filteredAirports.length,
                itemBuilder: (_, index) {
                  final airport = dropdownController.filteredAirports.isEmpty
                      ? dropdownController.allAirports[index]
                      : dropdownController.filteredAirports[index];
                  return ListTile(
                    onTap: () {
                      // final String
                      controller.text =
                          "${airport.locality}, ${airport.country}";
                      dropdownController.selectAirport(airport);

                      dropdownController.selectedDeparture.value = airport.iata;
                      dropdownController.selectedDepartureAirport.value =
                          airport;

                      dropdownController.searchText.value = airport.name;
                      dropdownController.hidePopup();
                      onChanged(airport.iata);
                      FocusScope.of(context).unfocus();
                    },
                    title: Text('${airport.locality}, ${airport.country}'),
                    subtitle: Text(airport.name),
                    trailing: Text(
                      airport.iata,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
