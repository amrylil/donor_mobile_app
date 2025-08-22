import 'package:donor_mobile_app/screens/home_screen.dart';
import 'package:donor_mobile_app/screens/lokasi_screen.dart';
import 'package:donor_mobile_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Pesan', style: TextStyle(fontSize: 24)),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    BloodDonationHomeScreen(),
    MapScreen(),
    ChatPage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: CustomAppBar(),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Container(
          key: ValueKey<int>(_selectedIndex),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),

      floatingActionButton: SizedBox(
        height: 60.0,
        width: 60.0,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFFE72929),
          shape: const CircleBorder(),
          child: const Icon(Icons.water_drop, color: Colors.white, size: 35),
          elevation: 2.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'DonorQ',
                style: TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Stack(
                    clipBehavior: Clip.none, // Agar notifikasi tidak terpotong
                    children: [
                      const Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFF6B7280),
                        size: 24,
                      ),
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEF4444),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final bool hasNotification;

  NavItem({
    required this.activeIcon,
    required this.inactiveIcon,
    this.hasNotification = false,
  });
}

// WIDGET BOTTOM NAVIGATION BAR YANG SUDAH DIPERBAIKI TOTAL
class CustomBottomAppBar extends StatelessWidget {
  final Function(int) onItemTapped;
  final int currentIndex;

  const CustomBottomAppBar({
    Key? key,
    required this.onItemTapped,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<NavItem> navItems = [
      NavItem(activeIcon: Icons.home, inactiveIcon: Icons.home_outlined),
      NavItem(activeIcon: Icons.search, inactiveIcon: Icons.search_outlined),
      NavItem(
        activeIcon: Icons.show_chart,
        inactiveIcon: Icons.show_chart_outlined,
        hasNotification: true,
      ),
      NavItem(activeIcon: Icons.person, inactiveIcon: Icons.person_outline),
    ];

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 7.0,
      color: const Color.fromARGB(255, 255, 255, 255),
      elevation: 1.0,
      shadowColor: Colors.black,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Grup ikon di sebelah KIRI
            Row(
              children: [
                _buildNavItem(context, navItems[0], 0),
                _buildNavItem(context, navItems[1], 1),
              ],
            ),
            Row(
              children: [
                _buildNavItem(context, navItems[2], 2),
                _buildNavItem(context, navItems[3], 3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, NavItem item, int index) {
    bool isSelected = currentIndex == index;
    final color = isSelected ? const Color(0xFFE72929) : Colors.grey[400];

    return SizedBox(
      width: MediaQuery.of(context).size.width / 5,
      child: InkWell(
        onTap: () => onItemTapped(index),
        borderRadius: BorderRadius.circular(30), // Efek ripple yang rapi
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? item.activeIcon : item.inactiveIcon,
                  color: color,
                  size: 28,
                ),
                if (item.hasNotification)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE72929),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
