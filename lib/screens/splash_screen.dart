import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final bool keepSignedIn;

  const SplashScreen({super.key, required this.keepSignedIn});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        widget.keepSignedIn ? '/main' : '/login',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0F1115) : const Color(0xFFFFF7F2);

    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFB923C), Color(0xFFE84D7A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  size: 42,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 22),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                  children: [
                    TextSpan(
                      text: 'Exce',
                      style: TextStyle(color: Color(0xFFFB923C)),
                    ),
                    TextSpan(
                      text: 'lerate',
                      style: TextStyle(color: Color(0xFFE84D7A)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Learn smarter. Grow faster.',
                style: TextStyle(
                  color: isDark
                      ? const Color(0xFFAAB2C0)
                      : const Color(0xFF6B7280),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 28),
              const CircularProgressIndicator(
                color: Color(0xFFFB923C),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
