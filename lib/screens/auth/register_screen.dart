import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui'; // Diperlukan untuk ImageFilter.blur

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _agreeToTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    // Mengambil tema teks dari context, yang sekarang sudah menggunakan font 'Jost'
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // backgroundColor sudah diatur di theme, tapi bisa di-override di sini jika perlu
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // --- Shadow untuk Blob ---
              Positioned(
                top: -120,
                right: -15,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: SvgPicture.asset(
                    'assets/images/blob.svg',
                    width: 360,
                    height: 390,
                    fit: BoxFit.contain,
                    // Warna shadow diubah menjadi gelap
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

              // --- Blob Utama ---
              Positioned(
                top: -130,
                right: -20,
                child: SvgPicture.asset(
                  'assets/images/blob.svg',
                  width: 350,
                  height: 380,
                  fit: BoxFit.contain,
                ),
              ),

              // --- Konten Utama ---
              SafeArea(
                child: Padding(
                  // Memberikan margin horizontal 32 dan vertikal 24
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),

                      // Teks Welcome untuk Register
                      Text(
                        'Bergabung,',
                        style: textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Daftar!',
                        style: textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Input field untuk Nama Lengkap
                      _buildTextField(
                        label: 'NAMA LENGKAP',
                        hint: 'Masukkan nama lengkap',
                        controller: _nameController,
                        textTheme: textTheme,
                      ),

                      const SizedBox(height: 20),

                      // Input field untuk Email
                      _buildTextField(
                        label: 'ALAMAT EMAIL',
                        hint: 'nama@email.com',
                        controller: _emailController,
                        textTheme: textTheme,
                      ),

                      const SizedBox(height: 20),

                      // Input field untuk Password
                      _buildTextField(
                        label: 'KATA SANDI',
                        hint: '••••••••••',
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textTheme: textTheme,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      _buildTextField(
                        label: 'KONFIRMASI KATA SANDI',
                        hint: '••••••••••',
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        textTheme: textTheme,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Tombol Register
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),

                          // Warna gradient tombol diubah menjadi merah
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF87171), Color(0xFFDC2626)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: _agreeToTerms
                              ? () {
                                  // Tambahkan logika register di sini
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            disabledBackgroundColor: Colors.grey[400],
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Daftar',
                                style: textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sudah punya akun? ',
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/login',
                                );
                              },
                              child: Text(
                                'Masuk di sini',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
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

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required TextTheme textTheme,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: textTheme.bodyLarge?.copyWith(color: Colors.grey[500]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
