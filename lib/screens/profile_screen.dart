import 'package:flutter/material.dart';
import '../main.dart';
import '../services/user_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'Learner';
  String email = 'user@example.com';
  String password = '';
  String skillLevel = 'Beginner';
  String progress = '0% Completed';

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
      password = user['password'] ?? '';
      skillLevel = user['skillLevel'] ?? 'Beginner';
      progress = user['progress'] ?? '0% Completed';
    });
  }

  Future<void> _handleLogout() async {
    await UserPrefs.setLoginState(isLoggedIn: false, keepSignedIn: false);
    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed('/login');
  }

  Future<void> _toggleTheme(bool isDarkMode) async {
    appThemeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_mode', isDarkMode);
    if (!mounted) return;
    setState(() {});
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: username);
    final emailController = TextEditingController(text: email);
    final passwordController = TextEditingController(text: password);
    final formKey = GlobalKey<FormState>();
    bool obscurePassword = true;

    showDialog(
      context: context,
      builder: (dialogContext) {
        final isDark = Theme.of(dialogContext).brightness == Brightness.dark;
        final textColor = Theme.of(dialogContext).colorScheme.onSurface;
        final subTextColor = isDark
            ? const Color(0xFFAAB2C0)
            : const Color(0xFF6B7280);

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Container(
                width: 520,
                constraints: const BoxConstraints(maxWidth: 520),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(dialogContext).dialogTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Update Profile',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Update your username, email address, and password.',
                          style: TextStyle(
                            fontSize: 14,
                            color: subTextColor,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Username',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter username',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Username cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'Enter email',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email cannot be empty';
                            }
                            if (!value.contains('@')) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: passwordController,
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'Enter password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setDialogState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(dialogContext),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (!formKey.currentState!.validate()) return;

                                  await UserPrefs.saveUser(
                                    username: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text,
                                    skillLevel: skillLevel,
                                    progress: progress,
                                  );

                                  if (!mounted) return;

                                  setState(() {
                                    username = nameController.text.trim();
                                    email = emailController.text.trim();
                                    password = passwordController.text;
                                  });

                                  if (!dialogContext.mounted) return;
                                  Navigator.pop(dialogContext);

                                  ScaffoldMessenger.of(
                                    this.context,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Profile updated successfully',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                child: const Text('Save Changes'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showNotificationsDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final textColor = Theme.of(dialogContext).colorScheme.onSurface;

        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              child: Container(
                width: 460,
                constraints: const BoxConstraints(maxWidth: 460),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(dialogContext).dialogTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Notification Settings',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SwitchListTile(
                      title: Text(
                        'Push Notifications',
                        style: TextStyle(color: textColor),
                      ),
                      value: pushEnabled,
                      onChanged: (val) {
                        setStateDialog(() => pushEnabled = val);
                        setState(() => pushEnabled = val);
                      },
                    ),
                    SwitchListTile(
                      title: Text(
                        'Email Notifications',
                        style: TextStyle(color: textColor),
                      ),
                      value: emailEnabled,
                      onChanged: (val) {
                        setStateDialog(() => emailEnabled = val);
                        setState(() => emailEnabled = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
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
    final textColor = Theme.of(context).colorScheme.onSurface;
    final iconColor = isDark
        ? const Color(0xFFAAB2C0)
        : const Color(0xFF4B5563);

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
                    backgroundColor: primary.withValues(alpha: 0.18),
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
                  Text(email, style: TextStyle(fontSize: 16, color: iconColor)),
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
                    onChanged: _toggleTheme,
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
    final borderColor = isDark
        ? const Color(0xFF232833)
        : const Color(0xFFF1D3BE);
    final textColor = Theme.of(context).colorScheme.onSurface;

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
              color: textColor,
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
    final labelColor = isDark
        ? const Color(0xFFAAB2C0)
        : const Color(0xFF6B7280);
    final valueColor = Theme.of(context).colorScheme.onSurface;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 15, color: labelColor)),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
