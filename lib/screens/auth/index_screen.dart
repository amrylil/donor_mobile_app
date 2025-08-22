import 'package:donor_mobile_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthIndexPage extends StatelessWidget {
  const AuthIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AuthService authService = AuthService();

    return Scaffold(
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
                    offset: const Offset(0, -5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "DONORQ",
                          style: textTheme.headlineMedium?.copyWith(
                            color: Colors.black87,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
              Text(
                'Berbagi Darah',
                style: textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
              ),
              Text(
                'Menyatukan Sesama Manusia',
                style: textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),

              _buildPrimaryButton(
                text: 'Lanjutkan dengan Google',
                icon: SvgPicture.asset(
                  'assets/icons/google.svg',
                  height: 22,
                  width: 22,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mencoba masuk dengan Google...'),
                      duration: Duration(seconds: 4),
                    ),
                  );

                  final String? sessionToken = await authService
                      .signInWithGoogle();

                  if (!context.mounted) return;
                  if (sessionToken != null) {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Login dengan Google berhasil!'),
                      ),
                    );
                    Navigator.pushReplacementNamed(context, '/');
                  } else {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          'Gagal login dengan Google. Silakan coba lagi.',
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              _buildSecondaryButton(
                text: 'Gunakan email atau telepon',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
              ),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(
                    'assets/icons/twitter.svg',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur login Twitter belum tersedia.'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 24),
                  // Facebook sekarang di sini
                  _buildSocialIcon(
                    'assets/icons/facebook.svg',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur login Facebook belum tersedia.'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 24),
                  _buildSocialIcon(
                    'assets/icons/linkedln.svg',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur login LinkedIn belum tersedia.'),
                        ),
                      );
                    },
                  ),
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
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Masuk',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.red[700],
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

  // Helper widget untuk tombol utama - DIMODIFIKASI
  Widget _buildPrimaryButton({
    required String text,
    required Widget
    icon, // Diubah dari IconData menjadi Widget agar lebih fleksibel
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
        icon: icon, // Langsung menggunakan widget ikon yang diberikan
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
          foregroundColor: Colors.grey[800],
          side: BorderSide(color: Colors.grey[400]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  // Helper widget untuk ikon sosial media
  Widget _buildSocialIcon(String assetPath, {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey[200],
        child: SvgPicture.asset(
          assetPath,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(Colors.grey[800]!, BlendMode.srcIn),
        ),
      ),
    );
  }
}
