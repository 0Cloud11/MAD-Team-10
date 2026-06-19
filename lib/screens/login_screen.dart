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
  bool _isLoading = false;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_loginController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1)); // Simulate server delay

    final user = await UserPrefs.getUser();
    final savedUsername = (user['username'] ?? '').trim();
    final savedEmail = (user['email'] ?? '').trim();
    final savedPassword = user['password'] ?? '';

    final bool loginMatches =
        _loginController.text.trim().toLowerCase() ==
            savedUsername.toLowerCase() ||
        _loginController.text.trim().toLowerCase() == savedEmail.toLowerCase();
    final bool passwordMatches = _passwordController.text == savedPassword;

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

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
                          color: Colors.grey,
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
                        onChanged: (value) =>
                            setState(() => _keepSignedIn = value ?? false),
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
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                    child: Text(
                      'If you don\'t have an account, Sign Up',
                      style: TextStyle(
                        fontSize: 12,
                        color: primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text('LOGIN'),
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
