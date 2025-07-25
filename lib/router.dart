import 'package:donor_mobile_app/screens/auth/index_screen.dart';
import 'package:donor_mobile_app/screens/auth/login_screen.dart';
import 'package:donor_mobile_app/screens/auth/register_screen.dart';
import 'package:donor_mobile_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => BloodDonationHomeScreen()),
    GoRoute(path: '/auth', builder: (context, state) => AuthIndexPage()),
    GoRoute(path: '/auth/login', builder: (context, state) => LoginPage()),
    GoRoute(
      path: '/auth/register',
      builder: (context, state) => RegisterPage(),
    ),
  ],
);
