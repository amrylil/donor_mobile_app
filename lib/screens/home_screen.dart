import 'package:donor_mobile_app/services/profile_service.dart';
import 'package:donor_mobile_app/widgets/corousel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BloodDonationHomeScreen extends StatelessWidget {
  const BloodDonationHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Langsung kembalikan kontennya, tanpa Scaffold dan SafeArea
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200, // Anda bisa sesuaikan tingginya
            child: const MyImageCarousel(),
          ),

          // 3. Modern Quick Actions
          _buildModernQuickActionsSection(textTheme),

          // 4. Urgent Need Card
          _buildModernUrgentNeedSection(textTheme),
          _buildModernSchedulesSection(textTheme),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildModernQuickActionsSection(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aksi Cepat',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            physics:
                const NeverScrollableScrollPhysics(), // Agar tidak bisa di-scroll sendiri
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio:
                1.1, // Sesuaikan rasio aspek agar kotak terlihat proporsional
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: <Widget>[
              _buildQuickActionItem(
                icon: Icons.search_rounded,
                label: 'Find Donors',
                color: const Color(0xFFEF4444),
                onTap: () {},
              ),
              _buildQuickActionItem(
                icon: Icons.invert_colors_rounded,
                label: 'Donates',
                color: const Color(0xFFEF4444),
                onTap: () {},
              ),
              _buildQuickActionItem(
                icon: Icons.water_drop_rounded,
                label: 'Order Bloods',
                color: const Color(0xFFEF4444),
                onTap: () {},
              ),
              _buildQuickActionItem(
                icon: Icons.medical_services_rounded,
                label: 'Assistant',
                color: const Color(0xFF06B6D4),
                onTap: () {},
              ),
              _buildQuickActionItem(
                icon: Icons.report_rounded,
                label: 'Report',
                color: const Color(0xFF8B5CF6),
                onTap: () {},
              ),
              _buildQuickActionItem(
                icon: Icons.campaign_rounded,
                label: 'Campaign',
                color: const Color(0xFF10B981),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernActionCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  // 4. Modern Urgent Need Section
  Widget _buildModernUrgentNeedSection(TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFFDC2626),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'A+',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🚨 DIBUTUHKAN SEGERA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'RS Wahidin Sudirohusodo',
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Pasien kecelakaan membutuhkan 3 kantong darah A+',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  // 5. Modern Schedules Section
  Widget _buildModernSchedulesSection(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jadwal Terdekat',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('Lihat Semua')),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildModernScheduleCard(
                  'Kantor PMI Makassar',
                  '25 Juli 2025',
                  '08:00 - 14:00',
                  '2.3 km',
                  const Color(0xFF3B82F6),
                ),
                _buildModernScheduleCard(
                  'Mall Panakkukang',
                  '27 Juli 2025',
                  '10:00 - 16:00',
                  '4.1 km',
                  const Color(0xFF10B981),
                ),
                _buildModernScheduleCard(
                  'Universitas Hasanuddin',
                  '30 Juli 2025',
                  '09:00 - 15:00',
                  '6.8 km',
                  const Color(0xFFF59E0B),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernScheduleCard(
    String location,
    String date,
    String time,
    String distance,
    Color color,
  ) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.location_on_rounded, color: color, size: 20),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  distance,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            location,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                color: Colors.grey[500],
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                color: Colors.grey[500],
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                time,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 6. Modern Education Section
}
