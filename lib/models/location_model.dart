import 'package:latlong2/latlong.dart';

// Model untuk merepresentasikan satu objek lokasi dari API
class LocationModel {
  final String locationName;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final DateTime createdAt;

  LocationModel({
    required this.locationName,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  // Factory constructor untuk membuat instance LocationModel dari JSON
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      locationName: json['location_name'] ?? 'Nama Tidak Diketahui',
      address: json['address'] ?? 'Alamat Tidak Diketahui',
      city: json['city'] ?? 'Kota Tidak Diketahui',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  // Helper untuk mendapatkan koordinat sebagai objek LatLng
  LatLng get point => LatLng(latitude, longitude);
}
