// ignore_for_file: public_member_api_docs, sort_constructors_first
class AirportModel {
  final String name;
  final String latitude;
  final String longitude;
   String? place;
   String? locality;
   String? country;
  final String iata;

  AirportModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.place,
    this.locality,
     this.country,
    required this.iata,
  });

  factory AirportModel.fromJson(Map<String, dynamic> json) {
    return AirportModel(
      name: json['airport_name'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      iata: json['city_iata_code'] ?? '',
      
    );
  }

  factory AirportModel.empty() {
    return AirportModel(
      name: '',
      locality: '',
      country: '',
      iata: '',
      latitude: '',
      longitude: '',
      place: '',
    );
  }
}
