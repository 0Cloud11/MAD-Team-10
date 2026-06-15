import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/program.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_layout.dart';
import 'screens/program_details_screen.dart';
import 'screens/program_listing_screen.dart';
import 'screens/signup_screen.dart';

// Global notifier for Dark/Light mode
final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier(ThemeMode.light);

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
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Your App Name',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          // LIGHT THEME
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFFFF7F2),
            primaryColor: const Color(0xFFFB923C),
            cardColor: Colors.white,
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
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
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
            ),
          ),
          // DARK THEME
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
            primaryColor: const Color(0xFFFB923C),
            cardColor: const Color(0xFF1F1E2E),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFB923C),
              secondary: Color(0xFFFB923C),
              surface: Color(0xFF121212),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1F1E2E),
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF2C2A3A),
              hintStyle: const TextStyle(
                color: Color(0xFFA09CAB),
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
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
              backgroundColor: Color(0xFF000000),
              selectedItemColor: Color(0xFFFB923C),
              unselectedItemColor: Color(0xFFB6B1C8),
              type: BottomNavigationBarType.fixed,
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
