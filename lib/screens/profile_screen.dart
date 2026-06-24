import 'package:flutter/material.dart';
import '../services/user_prefs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> _user = {};

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await UserPrefs.getUser();
    if (!mounted) return;
    setState(() {
      _user = user;
    });
  }

  Future<void> _logout() async {
    await UserPrefs.setLoginState(
      isLoggedIn: false,
      keepSignedIn: false,
    );

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future<void> _editProfile() async {
    final usernameController =
        TextEditingController(text: _user['username'] ?? '');
    final emailController = TextEditingController(text: _user['email'] ?? '');
    final skillController =
        TextEditingController(text: _user['skillLevel'] ?? 'Beginner');
    final progressController =
        TextEditingController(text: _user['progress'] ?? '0% Completed');
    final currentPassword = _user['password'] ?? '';

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(hintText: 'username'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'email'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: skillController,
                  decoration: const InputDecoration(hintText: 'skill level'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: progressController,
                  decoration: const InputDecoration(hintText: 'progress'),
                ),
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: 100,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  await UserPrefs.saveUser(
                    username: usernameController.text.trim(),
                    email: emailController.text.trim(),
                    password: currentPassword,
                    skillLevel: skillController.text.trim(),
                    progress: progressController.text.trim(),
                  );
                  if (!mounted) return;
                  Navigator.pop(dialogContext);
                  _loadUser();
                },
                child: const Text('Save'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _infoTile(String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark ? const Color(0xFF2D3340) : const Color(0xFFF1D3BE);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value.isEmpty ? 'Not set' : value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brandOrange = Theme.of(context).colorScheme.primary;
    final brandPink = Theme.of(context).colorScheme.secondary;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.auto_awesome_rounded, color: Color(0xFFFB923C)),
                SizedBox(width: 8),
                Text(
                  'Excelerate Profile',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE84D7A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  colors: [brandOrange, brandPink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                _user['username']?.toString().isNotEmpty == true
                    ? _user['username']
                    : 'Learner',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _infoTile('EMAIL', _user['email'] ?? ''),
            _infoTile('SKILL LEVEL', _user['skillLevel'] ?? ''),
            _infoTile('PROGRESS', _user['progress'] ?? ''),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _editProfile,
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
