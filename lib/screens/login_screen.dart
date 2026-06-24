import 'package:flutter/material.dart';
import '../services/user_prefs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _keepSignedIn = false;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final enteredLogin = _loginController.text.trim();
    final enteredPassword = _passwordController.text;

    final user = await UserPrefs.getUser();
    final savedUsername = (user['username'] ?? '').trim();
    final savedEmail = (user['email'] ?? '').trim();
    final savedPassword = user['password'] ?? '';

    final bool loginMatches =
        enteredLogin.toLowerCase() == savedUsername.toLowerCase() ||
        enteredLogin.toLowerCase() == savedEmail.toLowerCase();

    final bool passwordMatches = enteredPassword == savedPassword;

    if (loginMatches && passwordMatches) {
      await UserPrefs.setLoginState(
        isLoggedIn: true,
        keepSignedIn: _keepSignedIn,
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username/email or password.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _brandHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Row(
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              color: Color(0xFFFB923C),
              size: 28,
            ),
            SizedBox(width: 8),
            Text(
              'Excelerate',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Color(0xFFE84D7A),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Sign in to continue your learning journey.',
          style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.tertiary;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _brandHeader(),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    colors: [
                      secondary,
                      isDark
                          ? const Color(0xFF2A3140)
                          : const Color(0xFF35324B),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'USERNAME / EMAIL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _loginController,
                decoration: const InputDecoration(hintText: 'username/email'),
              ),
              const SizedBox(height: 20),
              const Text(
                'PASSWORD',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: _keepSignedIn,
                    activeColor: const Color(0xFFFB923C),
                    onChanged: (value) {
                      setState(() {
                        _keepSignedIn = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Keep me signed in',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  'If you don’t have an account, Sign Up',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.secondary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _handleLogin,
                child: const Text('LOGIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
