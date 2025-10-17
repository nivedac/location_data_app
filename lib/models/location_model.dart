class LocationModel {
  final int id;
  String placeName;
  String country;
  double latitude;
  double longitude;

  LocationModel({
    required this.id,
    required this.placeName,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: int.parse(json['id'].toString()),
      placeName: json['placeName'],
      country: json['country'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'placeName': placeName,
        'country': country,
        'latitude': latitude,
        'longitude': longitude,
      };
}
