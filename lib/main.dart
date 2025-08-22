import 'package:provider/provider.dart';
import 'package:donor_mobile_app/providers/auth_provider.dart';
import 'package:donor_mobile_app/helpers/auth_guard.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:donor_mobile_app/widgets/main_navigation.dart';
import 'package:donor_mobile_app/screens/auth/login_screen.dart';
import 'package:donor_mobile_app/screens/auth/register_screen.dart';
import 'package:donor_mobile_app/screens/auth/index_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
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
      home: const AuthGuard(),

      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/auth': (context) => const AuthIndexPage(),
        '/home': (context) => const MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
