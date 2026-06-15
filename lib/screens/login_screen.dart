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
    if (!mounted) return;

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

      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username/email or password.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              color: secondary,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(30),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'USERNAME / EMAIL:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _loginController,
                    decoration: const InputDecoration(
                      hintText: 'Username/ Email',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'PASSWORD:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFF5F5555),
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
                        activeColor: primary,
                        value: _keepSignedIn,
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
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: Text(
                      'If you don\'t have an account, Sign Up',
                      style: TextStyle(
                        fontSize: 12,
                        color: secondary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text('LOGIN'),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/512px-Google_%22G%22_Logo.svg.png',
                        height: 34,
                        width: 34,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error_outline),
                      ),
                      const SizedBox(width: 28),
                      const Icon(Icons.apple, size: 42),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
