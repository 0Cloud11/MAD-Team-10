import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            onPressed: () {},
            child: const Text('ADD'),
          ),
          const SizedBox(height: 30),
          _buildProfileRow(context, 'NAME', 'Demo User'),
          _buildProfileRow(context, 'EMAIL', 'demo@user.com'),
          _buildProfileRow(context, 'SKILL LEVEL:', 'Intermediate'),
          _buildProfileRow(context, 'PROGRESS:', '65% Completed'),
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
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
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
      color: Theme.of(context).primaryColor.withOpacity(0.8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
