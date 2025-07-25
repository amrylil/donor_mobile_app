import 'package:donor_mobile_app/models/location_model.dart';
import 'package:donor_mobile_app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final LocationService _locationService = LocationService();

  // State untuk menampung data, status loading, dan pesan error
  late Future<List<LocationModel>> _locationsFuture;

  @override
  void initState() {
    super.initState();
    // Panggil service untuk mengambil data saat halaman pertama kali dibuka
    _locationsFuture = _locationService.fetchLocations();
  }

  void _moveToLocation(LatLng point) {
    _mapController.move(point, 15.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: FutureBuilder<List<LocationModel>>(
        future: _locationsFuture,
        builder: (context, snapshot) {
          // 1. Saat data sedang dimuat
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. Jika terjadi error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // 3. Jika data kosong atau tidak ada
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Tidak ada lokasi yang ditemukan.'),
            );
          }

          // 4. Jika data berhasil dimuat
          final locations = snapshot.data!;
          final markers = _buildMarkers(locations);

          return Column(
            children: [
              Expanded(flex: 3, child: _buildMapContainer(markers)),
              _buildListHeader(locations.length),
              Expanded(flex: 2, child: _buildLocationList(locations)),
            ],
          );
        },
      ),
    );
  }

  List<Marker> _buildMarkers(List<LocationModel> locations) {
    return locations.map((location) {
      return Marker(
        width: 40.0,
        height: 40.0,
        point: location.point,
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Lokasi: ${location.locationName}")),
            );
          },
          child: const Icon(Icons.location_on, color: Colors.red, size: 40),
        ),
      );
    }).toList();
  }

  Widget _buildMapContainer(List<Marker> markers) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: LatLng(-5.147665, 119.432732),
            zoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(markers: markers),
          ],
        ),
      ),
    );
  }

  Widget _buildListHeader(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Lokasi Terdekat',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count lokasi',
              style: const TextStyle(
                color: Color(0xFFEF4444),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationList(List<LocationModel> locations) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.05),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.red[100],
              child: Icon(Icons.bloodtype, color: Colors.red[700]),
            ),
            title: Text(
              location.locationName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(location.address),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _moveToLocation(location.point);
            },
          ),
        );
      },
    );
  }
}
