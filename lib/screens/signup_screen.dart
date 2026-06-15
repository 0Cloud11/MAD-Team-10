import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/user_prefs.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  String _password = '';
  double _passwordStrength = 0;
  String _strengthLabel = '';
  Color _strengthColor = Colors.transparent;

  final int _minPasswordLength = 8;
  final int _maxPasswordLength = 16;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _hasMinLength => _password.length >= _minPasswordLength;
  bool get _hasUppercase => RegExp(r'[A-Z]').hasMatch(_password);
  bool get _hasLowercase => RegExp(r'[a-z]').hasMatch(_password);
  bool get _hasNumber => RegExp(r'[0-9]').hasMatch(_password);
  bool get _hasSpecialChar =>
      RegExp(r'[!@#\$&*~%^()_\-+=<>?/{}[\]|.,]').hasMatch(_password);
  bool get _hasNoSpaces => !RegExp(r'\s').hasMatch(_password);

  bool get _isPasswordAcceptable =>
      _hasMinLength &&
      _hasUppercase &&
      _hasLowercase &&
      _hasNumber &&
      _hasSpecialChar &&
      _hasNoSpaces;

  void _checkPasswordStrength(String value) {
    setState(() {
      _password = value;

      if (value.isEmpty) {
        _passwordStrength = 0;
        _strengthLabel = '';
        _strengthColor = Colors.transparent;
        return;
      }

      int score = 0;
      if (_hasMinLength) score++;
      if (_hasUppercase && _hasLowercase) score++;
      if (_hasNumber) score++;
      if (_hasSpecialChar) score++;
      if (_hasNoSpaces) score++;

      if (score <= 2) {
        _passwordStrength = 0.35;
        _strengthLabel = 'Weak';
        _strengthColor = Colors.red;
      } else if (score == 3 || score == 4) {
        _passwordStrength = 0.7;
        _strengthLabel = 'Good';
        _strengthColor = Colors.orange;
      } else {
        _passwordStrength = 1.0;
        _strengthLabel = 'Strong';
        _strengthColor = Colors.green;
      }
    });
  }

  Future<void> _handleSignUp() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a username.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_isPasswordAcceptable) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password must be $_minPasswordLength-$_maxPasswordLength characters, include uppercase, lowercase, number, special character, and no spaces.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await UserPrefs.saveUser(
      username: username,
      email: email,
      password: password,
      skillLevel: 'Beginner',
      progress: '0% Completed',
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully. Please log in.'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacementNamed(context, '/login');
  }

  Widget _buildSuggestionItem(String text, bool isValid) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 18,
          color: isValid
              ? Colors.green
              : (isDark ? Colors.white30 : Colors.black45),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isValid
                  ? Colors.green
                  : (isDark ? Colors.white70 : Colors.black54),
              fontWeight: isValid ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerBg = isDark ? const Color(0xFF121212) : const Color(0xFF1F1E2E);
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: headerBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.bottomLeft,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'USERNAME:',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
              const SizedBox(height: 20),
              Text(
                'EMAIL:',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(height: 20),
              Text(
                'PASSWORD:',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                onChanged: _checkPasswordStrength,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  LengthLimitingTextInputFormatter(_maxPasswordLength),
                ],
                decoration: InputDecoration(
                  hintText: 'Password',
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
              if (_password.isNotEmpty) ...[
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: _passwordStrength,
                  minHeight: 6,
                  backgroundColor: isDark
                      ? Colors.white12
                      : Colors.grey.shade300,
                  color: _strengthColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 6),
                Text(
                  'Strength: $_strengthLabel',
                  style: TextStyle(
                    color: _strengthColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark
                          ? Colors.transparent
                          : const Color(0xFFF1D3BE),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password suggestions',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildSuggestionItem(
                        'Use $_minPasswordLength to $_maxPasswordLength characters',
                        _password.length >= _minPasswordLength &&
                            _password.length <= _maxPasswordLength,
                      ),
                      const SizedBox(height: 6),
                      _buildSuggestionItem(
                        'Add at least one uppercase letter',
                        _hasUppercase,
                      ),
                      const SizedBox(height: 6),
                      _buildSuggestionItem(
                        'Add at least one lowercase letter',
                        _hasLowercase,
                      ),
                      const SizedBox(height: 6),
                      _buildSuggestionItem(
                        'Add at least one number',
                        _hasNumber,
                      ),
                      const SizedBox(height: 6),
                      _buildSuggestionItem(
                        'Add at least one special character',
                        _hasSpecialChar,
                      ),
                      const SizedBox(height: 6),
                      _buildSuggestionItem('Do not use spaces', _hasNoSpaces),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'If you have an account already, LOGIN',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? Theme.of(context).primaryColor
                        : const Color(0xFF1F1E2E),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSignUp,
                child: const Text('SIGN UP'),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/960px-Google_%22G%22_logo.svg.png',
                    height: 34,
                    width: 34,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.g_mobiledata,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 28),
                  Icon(Icons.apple, size: 42, color: textColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
