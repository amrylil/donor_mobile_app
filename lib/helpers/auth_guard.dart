import 'package:donor_mobile_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:donor_mobile_app/screens/auth/index_screen.dart';
import 'package:donor_mobile_app/widgets/main_navigation.dart';

class AuthGuard extends StatelessWidget {
  final _storage = const FlutterSecureStorage();

  const AuthGuard({super.key});

  Future<bool> _isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return const MainScreen();
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
