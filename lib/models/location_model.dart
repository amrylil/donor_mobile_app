import 'package:latlong2/latlong.dart';

// Model untuk merepresentasikan satu objek lokasi dari API
class LocationModel {
  final String locationName;
  final String address;
  final String city;
  final double latitude;
  final double distance;
  final double longitude;
  final DateTime createdAt;

  LocationModel({
    required this.locationName,
    required this.address,
    required this.city,
    required this.latitude,
    required this.distance,
    required this.longitude,
    required this.createdAt,
  });

  // Factory constructor untuk membuat instance LocationModel dari JSON
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      locationName:
          json['location_name'] ?? json['name'] ?? 'Nama Tidak Diketahui',

      address: json['address'] ?? 'Alamat Tidak Diketahui',
      city: json['city'] ?? 'Kota Tidak Diketahui',
      latitude: (json['latitude'] ?? json['lat'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] ?? json['lon'] as num?)?.toDouble() ?? 0.0,
      distance: json['distance'] != null
          ? (json['distance'] as num).toDouble()
          : 0.0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  LatLng get point => LatLng(latitude, longitude);
}
