import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:donor_mobile_app/models/location_model.dart';
import 'package:donor_mobile_app/helpers/location_helper.dart'; // pastikan ini ada

class LocationService {
  final String _baseUrl =
      'http://47.237.74.12:8080/api/v1/locations/by-user-location';

  Future<List<LocationModel>> fetchLocations() async {
    try {
      final posisi = await LocationHelper.getCurrentLocation();

      if (posisi == null) {
        throw Exception('Gagal mendapatkan lokasi pengguna');
      }

      final lat = posisi.latitude;
      final lon = posisi.longitude;

      final uri = Uri.parse(_baseUrl).replace(
        queryParameters: {'lat': lat.toString(), 'lon': lon.toString()},
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> locationList = jsonResponse['data'];

        return locationList
            .map((json) => LocationModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Gagal memuat data dari server (Status code: ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
