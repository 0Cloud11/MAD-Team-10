import 'package:flutter/material.dart';
import '../services/user_prefs.dart';
import 'main_layout.dart';
import 'signup_screen.dart';

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

  static const Color _hintColor = Color(0xFF6B5F5F);

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

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainLayout()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username/email or password.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required Color fillColor,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: _hintColor,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: themeColor,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(30),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
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
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration(
                      hintText: 'username or email',
                      fillColor: themeColor,
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
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    obscureText: !_isPasswordVisible,
                    decoration: _inputDecoration(
                      hintText: 'password',
                      fillColor: themeColor,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _hintColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
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
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'If you don\'t have an account, Sign Up',
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleLogin,
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/512px-Google_%22G%22_Logo.svg.png',
                        height: 35,
                        width: 35,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(width: 30),
                      const Icon(Icons.apple, size: 45),
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
