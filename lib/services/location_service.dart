import 'dart:convert';
import 'package:donor_mobile_app/models/location_model.dart';
import 'package:http/http.dart' as http;

class LocationService {
  final String _apiUrl = 'http://47.237.74.12:8080/api/v1/locations';

  Future<List<LocationModel>> fetchLocations() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        final List<dynamic> locationList = jsonResponse['data']['data'];

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
