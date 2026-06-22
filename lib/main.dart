import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/program.dart';
import 'screens/login_screen.dart';
import 'screens/main_layout.dart';
import 'screens/program_details_screen.dart';
import 'screens/signup_screen.dart';

final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool keepSignedIn = prefs.getBool('keep_signed_in') ?? false;
  final bool isDarkMode = prefs.getBool('is_dark_mode') ?? false;

  appThemeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;

  runApp(MyApp(keepSignedIn: keepSignedIn));
}

class MyApp extends StatelessWidget {
  final bool keepSignedIn;

  const MyApp({super.key, required this.keepSignedIn});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Blank',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFFFF7F2),
            primaryColor: const Color(0xFFFB923C),
            cardColor: Colors.white,
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFB923C),
              secondary: Color(0xFF1F1E2E),
              tertiary: Color(0xFF06B6D4), // Opposite color wheel accent
              surface: Color(0xFFFFFFFF),
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              onSurface: Color(0xFF1F2937),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF1F1E2E),
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              iconTheme: IconThemeData(color: Color(0xFF1F1E2E)),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFFFFECDD),
              hintStyle: const TextStyle(
                color: Color(0xFF5F5555),
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFFB923C),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFB923C),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 54),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF1F1E2E),
              selectedItemColor: Color(0xFFFB923C),
              unselectedItemColor: Color(0xFFB6B1C8),
              type: BottomNavigationBarType.fixed,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0F1115),
            primaryColor: const Color(0xFFFB923C),
            cardColor: const Color(0xFF1A1D24),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFB923C),
              secondary: Color(0xFFFFB067),
              tertiary: Color(0xFF06B6D4), // Opposite color wheel accent
              surface: Color(0xFF1A1D24),
              onPrimary: Colors.white,
              onSecondary: Colors.black,
              onSurface: Color(0xFFF5F7FA),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF161A22),
              foregroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF232833),
              hintStyle: const TextStyle(
                color: Color(0xFFAAB2C0),
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFFB923C),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFB923C),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 54),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF161A22),
              selectedItemColor: Color(0xFFFB923C),
              unselectedItemColor: Color(0xFF8C95A3),
              type: BottomNavigationBarType.fixed,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: const Color(0xFF1A1D24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          routes: {
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignUpScreen(),
            '/main': (context) => const MainLayout(),
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
      },
    );
  }
}
