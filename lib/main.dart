import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/program.dart';
import 'screens/login_screen.dart';
import 'screens/main_layout.dart';
import 'screens/program_details_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';

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
    const brandOrange = Color(0xFFFB923C);
    const brandPink = Color(0xFFE84D7A);
    const brandDark = Color(0xFF1F1E2E);
    const lightBg = Color(0xFFFFF7F2);
    const lightField = Color(0xFFFFECDD);
    const darkBg = Color(0xFF0F1115);
    const darkSurface = Color(0xFF1A1D24);
    const darkField = Color(0xFF232833);

    return MaterialApp(
      title: 'Excelerate',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightBg,
        primaryColor: brandOrange,
        colorScheme: const ColorScheme.light(
          primary: brandOrange,
          secondary: brandPink,
          tertiary: brandDark,
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xFF1F2937),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: brandDark,
          centerTitle: false,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: brandDark,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: IconThemeData(color: brandDark),
        ),
        cardColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightField,
          hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 15),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: brandOrange, width: 1.6),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: brandOrange,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            foregroundColor: brandDark,
            side: const BorderSide(color: Color(0xFFF1D3BE)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: brandDark,
          selectedItemColor: brandOrange,
          unselectedItemColor: Color(0xFFB6B1C8),
          type: BottomNavigationBarType.fixed,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkBg,
        primaryColor: brandOrange,
        colorScheme: const ColorScheme.dark(
          primary: brandOrange,
          secondary: brandPink,
          tertiary: Color(0xFF06B6D4),
          surface: darkSurface,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xFFF5F7FA),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: darkSurface,
          foregroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardColor: darkSurface,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkField,
          hintStyle: const TextStyle(color: Color(0xFFAAB2C0), fontSize: 15),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: brandOrange, width: 1.6),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: brandOrange,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            foregroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFF2D3340)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: darkSurface,
          selectedItemColor: brandOrange,
          unselectedItemColor: Color(0xFF8C95A3),
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
            builder: (context) => ProgramDetailsScreen(program: program),
          );
        }
        return null;
      },
      home: SplashScreen(keepSignedIn: keepSignedIn),
    );
  }
}
