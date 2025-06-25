import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:review_app/data/models/airport.dart';

class AirportController extends GetxController {
  var isLoading = false.obs;
  var airportList = <AirportModel>[].obs;
  var filteredAirports = <AirportModel>[].obs;

  final String _baseUrl = 'http://api.aviationstack.com/v1/airports';
  final String apiKey =
      'db0601a6180e009ecd2e755ea3c6728b'; // Put your real API key here

  // Fetch airports from API based on search query
  Future<void> fetchAirports() async {
    isLoading.value = true;

    try {
      final uri = Uri.parse(_baseUrl).replace(queryParameters: {
        'access_key': apiKey,
        'limit': '100',
      });

      final res = await http.get(uri);
      if (res.statusCode != 200) {
        throw Exception('Failed to load airports: ${res.statusCode}');
      }

      final Map<String, dynamic> data = json.decode(res.body);
      final List<dynamic> list = data['data'] ?? [];

      // Map JSON list to AirportModel list

      List<AirportModel> tempList = [];

      for (var json in list) {
        final airport = AirportModel.fromJson(json);

        // Perform reverse geocoding
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
              double.parse(airport.latitude.trim()),
              double.parse(airport.longitude.trim()));
          if (placemarks.isNotEmpty) {
            final p = placemarks.first;
            airport.locality = '${p.locality}';
            airport.country = '${p.country}';
            airport.place = p.locality!.isEmpty ? '${p.country}' :'${p.locality}, ${p.country}';
            print('airport place : ${airport.place}');
          }
        } catch (e) {
          print(e.toString());
          airport.place = '';
          airport.locality = '';
          airport.country = '';
        }

        tempList.add(airport);
      }

      airportList.value = tempList;

      print('airportList.value[0].place : ${airportList.value[0].place}');
      print('airportList.value[0].city : ${airportList.value[0].locality}');
      print('airportList.value[0].lat : ${airportList.value[0].latitude}');
      print(
          'airportList.value[0].lat : ${double.parse(airportList.value[0].latitude)}');
    } on http.ClientException catch (e) {
      Get.snackbar('Exception', e.toString());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // To handle selection (optional, if you want to store selected airport)
  var selectedAirport = Rx<AirportModel?>(null);
  void selectAirport(AirportModel airport) {
    selectedAirport.value = airport;
  }
}
