import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String _baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';
  static String _webClientId = dotenv.env['WEB_CLIENT_ID'] ?? '';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        if (json['success'] == true && json['data']['token'] != null) {
          await _storage.write(key: 'token', value: json['data']['token']);
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: _webClientId,
    clientId: _webClientId,
    scopes: ['email', 'profile'],
  );

  Future<String?> signInWithGoogle() async {
    if (_webClientId.isEmpty) {
      print(
        'Error: WEB_CLIENT_ID tidak ditemukan di file .env. Google Sign-In tidak dapat dilanjutkan.',
      );
      return null;
    }

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print('Login dibatalkan oleh pengguna.');
        return null; // Pengguna membatalkan login
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        print('Gagal mendapatkan ID Token dari Google.');
        return null;
      }

      print('Berhasil mendapatkan ID Token dari Google.');
      return await _sendTokenToBackend(idToken);
    } catch (error) {
      print('Terjadi error saat login dengan Google: $error');
      return null;
    }
  }

  Future<String?> _sendTokenToBackend(String idToken) async {
    try {
      print('Mengirim ID Token ke backend...');
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/google'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final sessionToken =
            responseData['data']?['token'] ?? responseData['session_token'];

        if (sessionToken != null) {
          print('Backend berhasil memverifikasi. Menerima session token.');
          await _storage.write(key: 'token', value: sessionToken);
          print('Session token berhasil disimpan.');
          return sessionToken;
        } else {
          print(
            'Verifikasi backend berhasil tetapi tidak ada token yang diterima.',
          );
          return null;
        }
      } else {
        print(
          'Backend gagal memverifikasi token. Status: ${response.statusCode}',
        );
        print('Response body: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Terjadi error saat mengirim token ke backend: $error');
      return null;
    }
  }

  /// Mendapatkan token dari secure storage.
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  /// Memeriksa apakah pengguna sudah login.
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  /// Menghapus token dari secure storage (logout).
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _storage.delete(key: 'token');
    print('User logged out.');
  }
}
