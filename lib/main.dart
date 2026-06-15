import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/program.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_layout.dart';
import 'screens/program_details_screen.dart';
import 'screens/program_listing_screen.dart';
import 'screens/signup_screen.dart';

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
      title: 'Blank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF7F2),
        primaryColor: const Color(0xFFFB923C),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFFB923C),
          secondary: Color(0xFF1F1E2E),
          surface: Color(0xFFFFF7F2),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1F1E2E),
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Color(0xFF1F1E2E),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: IconThemeData(color: Color(0xFF1F1E2E)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFFECDD),
          hintStyle: const TextStyle(color: Color(0xFF5F5555), fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFB923C), width: 1.4),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFB923C),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1F1E2E),
          selectedItemColor: Color(0xFFFB923C),
          unselectedItemColor: Color(0xFFB6B1C8),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(color: Color(0xFF374151), fontSize: 16),
          bodyMedium: TextStyle(color: Color(0xFF4B5563), fontSize: 14),
        ),
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/main': (context) => const MainLayout(),
        '/program-listing': (context) =>
            const ProgramListingScreen(showAppBar: true),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/program-details') {
          final program = settings.arguments as Program;
          return MaterialPageRoute(
            builder: (context) => const ProgramDetailsScreen(),
            settings: RouteSettings(arguments: program),
          );
        }
        return null;
      },
      home: keepSignedIn ? const MainLayout() : const LoginScreen(),
    );
  }
}
