import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return null;
    }

    // Cek permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return null;
    }

    // Ambil posisi saat ini
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
