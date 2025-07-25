import 'package:donor_mobile_app/models/location_model.dart';
import 'package:donor_mobile_app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final LocationService _locationService = LocationService();

  late Future<List<LocationModel>> _locationsFuture;
  Position? _currentPosition;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _locationsFuture = _locationService.fetchLocations();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _isLoadingLocation = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLoadingLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _isLoadingLocation = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _isLoadingLocation = false;
      });
    } catch (e) {
      setState(() => _isLoadingLocation = false);
    }
  }

  double _calculateDistance(double lat, double lon) {
    if (_currentPosition == null) return 0.0;

    return Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          lat,
          lon,
        ) /
        1000; // Convert to kilometers
  }

  void _moveToLocation(LatLng point) {
    _mapController.move(point, 15.0);
    HapticFeedback.lightImpact();
  }

  void _moveToCurrentLocation() {
    if (_currentPosition != null) {
      _mapController.move(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        15.0,
      );
      HapticFeedback.mediumImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: FutureBuilder<List<LocationModel>>(
        future: _locationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingState();
          }

          if (snapshot.hasError) {
            return _buildErrorState(snapshot.error.toString());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildEmptyState();
          }

          final locations = snapshot.data!;
          final markers = _buildMarkers(locations);

          return Column(
            children: [
              Expanded(flex: 3, child: _buildMapContainer(markers)),
              _buildDivider(),
              _buildListHeader(locations.length),
              Expanded(flex: 2, child: _buildLocationList(locations)),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: const Text(
        'Lokasi Donor Darah',
        style: TextStyle(
          color: Color(0xFF1E293B),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: _moveToCurrentLocation,
            icon: Icon(
              Icons.my_location_rounded,
              color: _currentPosition != null
                  ? const Color(0xFFEF4444)
                  : Colors.grey[400],
            ),
            tooltip: 'Lokasi Saya',
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color(0xFFEF4444)),
            strokeWidth: 3,
          ),
          SizedBox(height: 16),
          Text(
            'Memuat lokasi...',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: Color(0xFFEF4444),
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Terjadi Kesalahan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tidak dapat memuat data lokasi',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_off_rounded,
                color: Colors.grey[400],
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tidak Ada Lokasi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Belum ada lokasi donor darah yang tersedia',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<Marker> _buildMarkers(List<LocationModel> locations) {
    List<Marker> markers = locations.map((location) {
      return Marker(
        width: 50.0,
        height: 50.0,
        point: location.point,
        child: GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            _showLocationDetails(location);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.bloodtype_rounded,
              color: Color(0xFFEF4444),
              size: 28,
            ),
          ),
        ),
      );
    }).toList();

    // Add current location marker if available
    if (_currentPosition != null) {
      markers.add(
        Marker(
          width: 60.0,
          height: 60.0,
          point: LatLng(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      );
    }

    return markers;
  }

  Widget _buildMapContainer(List<Marker> markers) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: _currentPosition != null
                ? LatLng(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                  )
                : LatLng(-5.147665, 119.432732),
            zoom: 13.0,
            maxZoom: 18.0,
            minZoom: 10.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.donor_mobile_app',
            ),
            MarkerLayer(markers: markers),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.grey.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildListHeader(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Lokasi Terdekat',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFEF4444).withOpacity(0.1),
                  const Color(0xFFDC2626).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFEF4444).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: const Color(0xFFEF4444),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '$count lokasi',
                  style: const TextStyle(
                    color: Color(0xFFEF4444),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
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
        final distance = _calculateDistance(
          location.latitude,
          location.longitude,
        );

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                HapticFeedback.lightImpact();
                _moveToLocation(location.point);
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFEF4444).withOpacity(0.1),
                            const Color(0xFFDC2626).withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.bloodtype_rounded,
                        color: Color(0xFFEF4444),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location.locationName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            location.address,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (_currentPosition != null) ...[
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.near_me_rounded,
                                  size: 14,
                                  color: Colors.grey[500],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${distance.toStringAsFixed(1)} km',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLocationDetails(LocationModel location) {
    final distance = _calculateDistance(location.latitude, location.longitude);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.bloodtype_rounded,
                    color: Color(0xFFEF4444),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    location.locationName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailRow(Icons.location_on_rounded, location.address),
            _buildDetailRow(Icons.location_city_rounded, location.city),
            if (_currentPosition != null)
              _buildDetailRow(
                Icons.near_me_rounded,
                '${distance.toStringAsFixed(1)} km dari lokasi Anda',
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _moveToLocation(location.point);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Lihat di Peta',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
