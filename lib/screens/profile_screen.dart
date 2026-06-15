import 'package:flutter/material.dart';
import '../services/user_prefs.dart';
import '../main.dart'; // Access global theme notifier

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

  // Notification states
  bool pushEnabled = true;
  bool emailEnabled = false;

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

  void _showEditProfileDialog() {
    final TextEditingController nameController = TextEditingController(
      text: username,
    );
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() => username = nameController.text);
                await UserPrefs.saveUser(
                  username: username,
                  email: email,
                  password:
                      '', // Kept empty to not overwrite inadvertently without a full update
                  skillLevel: skillLevel,
                  progress: progress,
                );
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showNotificationsDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Notifications'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('Push Notifications'),
                    value: pushEnabled,
                    onChanged: (val) {
                      setStateDialog(() => pushEnabled = val);
                      setState(() => pushEnabled = val);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Email Notifications'),
                    value: emailEnabled,
                    onChanged: (val) {
                      setStateDialog(() => emailEnabled = val);
                      setState(() => emailEnabled = val);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final iconColor = isDark ? Colors.white70 : const Color(0xFF4B5563);

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
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white54 : const Color(0xFF6B7280),
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
                    leading: Icon(Icons.edit, color: iconColor),
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(color: textColor),
                    ),
                    trailing: Icon(Icons.chevron_right, color: iconColor),
                    contentPadding: EdgeInsets.zero,
                    onTap: _showEditProfileDialog,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      Icons.notifications_outlined,
                      color: iconColor,
                    ),
                    title: Text(
                      'Notifications',
                      style: TextStyle(color: textColor),
                    ),
                    trailing: Icon(Icons.chevron_right, color: iconColor),
                    contentPadding: EdgeInsets.zero,
                    onTap: _showNotificationsDialog,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(color: textColor),
                    ),
                    secondary: Icon(Icons.dark_mode_outlined, color: iconColor),
                    value: appThemeMode.value == ThemeMode.dark,
                    onChanged: (isDarkMode) {
                      setState(() {
                        appThemeMode.value = isDarkMode
                            ? ThemeMode.dark
                            : ThemeMode.light;
                      });
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;
    final borderColor = isDark ? Colors.transparent : const Color(0xFFF1D3BE);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: isDark ? Colors.white54 : const Color(0xFF6B7280),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : const Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }
}
