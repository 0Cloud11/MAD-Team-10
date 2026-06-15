import 'package:flutter/material.dart';
import '../services/user_prefs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'Learner';
  String email = 'user@example.com';
  String skillLevel = 'Beginner';
  String progress = '0% Completed';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = await UserPrefs.getUser();
    if (!mounted) return;

    setState(() {
      username = user['username'] ?? 'Learner';
      email = user['email'] ?? 'user@example.com';
      skillLevel = user['skillLevel'] ?? 'Beginner';
      progress = user['progress'] ?? '0% Completed';
    });
  }

  Future<void> _handleLogout() async {
    await UserPrefs.setLoginState(isLoggedIn: false, keepSignedIn: false);
    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: primary.withValues(alpha: 0.2),
                    child: Icon(Icons.person, size: 50, color: primary),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildProfileSection(
              title: 'Learning Progress',
              child: Column(
                children: [
                  _buildInfoRow('Skill Level', skillLevel),
                  const Divider(height: 24),
                  _buildInfoRow('Course Progress', progress),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildProfileSection(
              title: 'Settings',
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit, color: Color(0xFF4B5563)),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF4B5563),
                    ),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Edit profile coming soon'),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.notifications_outlined,
                      color: Color(0xFF4B5563),
                    ),
                    title: const Text('Notifications'),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF4B5563),
                    ),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Notifications settings coming soon'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _handleLogout,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'LOGOUT',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1D3BE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }
}
