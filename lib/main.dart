import 'package:donor_mobile_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:donor_mobile_app/screens/auth/index_screen.dart';
import 'package:donor_mobile_app/screens/auth/register_screen.dart';
import 'package:donor_mobile_app/widgets/main_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Darah Kita',
      theme: ThemeData(
        fontFamily: 'Jost',
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/auth',
      routes: {
        '/': (context) => const MainScreen(), // atau bisa AuthIndexPage()
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/auth': (context) => const AuthIndexPage(),
        // tambahkan route lain sesuai kebutuhan
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
