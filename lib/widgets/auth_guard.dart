import 'package:flutter/material.dart';
import 'package:donor_mobile_app/providers/auth_provider.dart';
import 'package:donor_mobile_app/screens/onboarding_screen.dart';
import 'package:donor_mobile_app/widgets/main_navigation.dart';
import 'package:provider/provider.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return authProvider.isLoggedIn
        ? const MainScreen()
        : const OnboardingScreen();
  }
}
