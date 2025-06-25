import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/airport_dropdown_Controller.dart';
import 'package:review_app/data/controller/airport_dropdown_ControllerArrival.dart';

class SearchableAirportDropdownArrival extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final dropdownControllerArrival = Get.put(AirportDropdownControllerArrival());
  final void Function(String iata) onChanged;

  SearchableAirportDropdownArrival(
      {Key? key, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: dropdownControllerArrival.hidePopup,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            focusNode: dropdownControllerArrival.focusNode,
            onChanged: (value) {
              dropdownControllerArrival.isPopupVisible.value = true;
              dropdownControllerArrival.searchText.value = value;
              dropdownControllerArrival
                  .filterAirports(dropdownControllerArrival.searchText.value);
            },
            onTap: () => dropdownControllerArrival.isPopupVisible.value = true,
            decoration: InputDecoration(
              hintText: dropdownControllerArrival.selectedArrival.value.isNotEmpty ? '${dropdownControllerArrival.selectedArrivalAirport.value.place}' : 'Search airport...',
              suffixIcon: Icon(Icons.arrow_drop_down),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          Obx(() {
            if (!dropdownControllerArrival.isPopupVisible.value)
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
                itemCount: dropdownControllerArrival.filteredAirports.isEmpty
                    ? dropdownControllerArrival.allAirports.length
                    : dropdownControllerArrival.filteredAirports.length,
                itemBuilder: (_, index) {
                  final airport =
                      dropdownControllerArrival.filteredAirports.isEmpty
                          ? dropdownControllerArrival.allAirports[index]
                          : dropdownControllerArrival.filteredAirports[index];
                  return ListTile(
                    onTap: () {
                      // final String
                      controller.text =
                          "${airport.locality}, ${airport.country}";
                      dropdownControllerArrival.selectAirport(airport);

                      dropdownControllerArrival.selectedArrival.value =
                          airport.iata;
                          dropdownControllerArrival.selectedArrivalAirport.value =
                          airport;

                      dropdownControllerArrival.searchText.value = airport.name;
                      dropdownControllerArrival.hidePopup();
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
