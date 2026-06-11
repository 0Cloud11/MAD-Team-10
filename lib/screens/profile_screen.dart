import 'package:flutter/material.dart';
import '../services/user_prefs.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'Demo User';
  String email = 'demo@user.com';
  String skillLevel = 'Beginner';
  String progress = '0% Completed';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await UserPrefs.getUser();
    setState(() {
      username = user['username'] ?? 'Demo User';
      email = user['email'] ?? 'demo@user.com';
      skillLevel = user['skillLevel'] ?? 'Beginner';
      progress = user['progress'] ?? '0% Completed';
    });
  }

  Future<void> _showEditDialog() async {
    final nameController = TextEditingController(text: username);
    final emailController = TextEditingController(text: email);
    final skillController = TextEditingController(text: skillLevel);
    final progressController = TextEditingController(text: progress);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: skillController,
                  decoration: const InputDecoration(labelText: 'Skill Level'),
                ),
                TextField(
                  controller: progressController,
                  decoration: const InputDecoration(labelText: 'Progress'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await UserPrefs.updateProfile(
                  username: nameController.text.trim(),
                  email: emailController.text.trim(),
                  skillLevel: skillController.text.trim(),
                  progress: progressController.text.trim(),
                );

                if (!mounted) return;
                Navigator.pop(context);
                await _loadUserData();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    await UserPrefs.logout();

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;

    return SafeArea(
      child: Column(
        children: [
          Container(
            color: themeColor,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: const Text(
              'HERE YOU CAN VIEW YOUR PROFILE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[200],
              foregroundColor: Colors.black,
            ),
            onPressed: _showEditDialog,
            child: const Text('EDIT'),
          ),
          const SizedBox(height: 30),
          _buildProfileRow(context, 'NAME', username),
          _buildProfileRow(context, 'EMAIL', email),
          _buildProfileRow(context, 'SKILL LEVEL', skillLevel),
          _buildProfileRow(context, 'PROGRESS', progress),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              onPressed: _logout,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'LOGOUT',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(BuildContext context, String label, String value) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor.withValues(alpha: 0.8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
