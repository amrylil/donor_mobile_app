import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  static const _storage = FlutterSecureStorage();
  static const _baseUrl = "https://donor-darah.duckdns.org/api/v1/profile/";

  static Future<Map<String, dynamic>?> getProfile() async {
    final token = await _storage.read(key: 'token');
    if (token == null) return null;

    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data']['user'];
    }
    return null;
  }
}
