import 'package:donor_mobile_app/screens/home_screen.dart';
import 'package:donor_mobile_app/screens/lokasi_screen.dart';
import 'package:donor_mobile_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Favorit', style: TextStyle(fontSize: 24)),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Pesan', style: TextStyle(fontSize: 24)),
    );
  }
}

class FolderPage extends StatelessWidget {
  const FolderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Folder', style: TextStyle(fontSize: 24)),
    );
  }
}

// Widget utama yang memiliki state
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

  // Daftar title untuk setiap halaman

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          Container(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // App name section
                    const Text(
                      'DARAH SIPATUO',
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Action buttons
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Notifikasi action
                            },
                            icon: Stack(
                              children: [
                                const Icon(
                                  Icons.notifications_rounded,
                                  color: Color(0xFF6B7280),
                                  size: 22,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
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
                  ],
                ),
              ),
            ),
          ),
          // Body content
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Container(
                key: ValueKey<int>(_selectedIndex),
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FloatingNavBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class NavItem {
  final IconData activeIcon;
  final IconData inactiveIcon;
  NavItem({required this.activeIcon, required this.inactiveIcon});
}

// Widget diubah menjadi StatelessWidget yang lebih ringan
class FloatingNavBar extends StatelessWidget {
  final Function(int) onItemTapped;
  final int currentIndex;

  const FloatingNavBar({
    Key? key,
    required this.onItemTapped,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<NavItem> navItems = [
      NavItem(
        activeIcon: Icons.home_rounded,
        inactiveIcon: Icons.home_outlined,
      ),
      NavItem(
        activeIcon: Icons.location_on_rounded,
        inactiveIcon: Icons.location_on_outlined,
      ),
      NavItem(
        activeIcon: Icons.chat_bubble_rounded,
        inactiveIcon: Icons.chat_bubble_outline_rounded,
      ),
      NavItem(
        activeIcon: Icons.person_rounded,
        inactiveIcon: Icons.person_rounded,
      ),
    ];

    // Menggunakan Container sederhana sebagai dasar
    return Container(
      height: 80, // Tinggi nav bar
      decoration: BoxDecoration(
        color: Colors.white,
        // Sudut membulat hanya di bagian atas
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5), // Shadow hanya ke arah atas
          ),
        ],
      ),
      child: SafeArea(
        top: false, // SafeArea hanya untuk bagian bawah
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(navItems.length, (index) {
            bool isSelected = currentIndex == index;
            final color = isSelected
                ? const Color.fromARGB(255, 231, 41, 41)
                : Colors.grey[400];

            return Expanded(
              child: GestureDetector(
                onTap: () => onItemTapped(index),
                behavior: HitTestBehavior.translucent,
                child: Center(
                  child: Icon(
                    isSelected
                        ? navItems[index].activeIcon
                        : navItems[index].inactiveIcon,
                    color: color,
                    size: 28,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
