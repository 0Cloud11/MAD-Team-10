import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/main_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool keepSignedIn = prefs.getBool('keep_signed_in') ?? false;

  runApp(MyApp(keepSignedIn: keepSignedIn));
}

class MyApp extends StatelessWidget {
  final bool keepSignedIn;

  const MyApp({super.key, required this.keepSignedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Course App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFEFAAAA),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEFAAAA)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: keepSignedIn ? const MainLayout() : const LoginScreen(),
    );
  }
}
