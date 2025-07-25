import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Jika logo Anda SVG

class AuthIndexPage extends StatelessWidget {
  const AuthIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil tema teks dari context (pastikan font 'Jost' sudah diatur di main.dart)
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // Latar belakang diubah menjadi putih
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Image.asset('assets/images/logo.png', width: 170, height: 180),
              Column(
                children: [
                  Transform.translate(
                    offset: Offset(0, -15), // naik 20 pixel
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // atau sesuai kebutuhan
                      children: [
                        Text(
                          "DARAH",

                          style: textTheme.headlineMedium?.copyWith(
                            color: Colors.black87,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'SIPATUO',
                          style: textTheme.titleLarge?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 2),

              const SizedBox(height: 10),
              Text(
                'Berbagi Darah',
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600], // Warna diubah
                ),
              ),
              Text(
                'Menyatukan Sesama Manusia',
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600], // Warna diubah
                ),
              ),

              const SizedBox(height: 30),

              _buildPrimaryButton(
                text: 'Lanjutkan dengan Facebook',
                icon: Icons.facebook,
                onPressed: () {},
              ),

              const SizedBox(height: 20),

              _buildSecondaryButton(
                text: 'Gunakan email atau telepon',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
              ),

              const SizedBox(height: 40),

              // --- Ikon Social Media Lainnya ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon('assets/icons/twitter.svg'), // Ganti path
                  const SizedBox(width: 24),
                  _buildSocialIcon('assets/icons/google.svg'), // Ganti path
                  const SizedBox(width: 24),
                  _buildSocialIcon('assets/icons/linkedin.svg'), // Ganti path
                ],
              ),

              const Spacer(flex: 3),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun? ',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ), // Warna diubah
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Masuk',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.red[700], // Warna diubah
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget untuk tombol utama
  Widget _buildPrimaryButton({
    required String text,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFFF87171), Color(0xFFDC2626)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  // Helper widget untuk tombol sekunder
  Widget _buildSecondaryButton({
    required String text,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(text),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          foregroundColor: Colors.grey[800], // Warna diubah
          side: BorderSide(color: Colors.grey[400]!), // Warna diubah
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  // Helper widget untuk ikon sosial media
  Widget _buildSocialIcon(String assetPath) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey[200], // Warna diubah
      child: SvgPicture.asset(
        assetPath,
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(
          Colors.grey[800]!,
          BlendMode.srcIn,
        ), // Warna diubah
      ),
    );
  }
}
