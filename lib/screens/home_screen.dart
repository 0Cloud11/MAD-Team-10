import 'package:flutter/material.dart';
import '../services/user_prefs.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onNavigateToPrograms;

  const HomeScreen({super.key, required this.onNavigateToPrograms});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = 'Learner';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final user = await UserPrefs.getUser();
    if (!mounted) return;
    setState(() {
      username = user['username'] ?? 'Learner';
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final welcomeBg = isDark
        ? const Color(0xFF1F1E2E)
        : const Color(0xFF1F1E2E);
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: welcomeBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, $username',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Explore opportunities, discover programs, and continue your Excelerate journey.',
                    style: TextStyle(
                      color: Color(0xFFE5E7EB),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton.icon(
                    onPressed:
                        widget.onNavigateToPrograms, // Switch to Programs tab
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Explore Programs'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(220, 48),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Quick Access',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 14),
            _buildMenuCard(
              context,
              icon: Icons.school_rounded,
              title: 'Programs',
              subtitle: 'Browse available learning opportunities',
              onTap: widget.onNavigateToPrograms, // Switch to Programs tab
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final primary = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final subTextColor = isDark
        ? const Color(0xFFA09CAB)
        : const Color(0xFF6B7280);
    final borderColor = isDark ? Colors.transparent : const Color(0xFFF1D3BE);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: primary, size: 28),
            const SizedBox(height: 14),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(fontSize: 13, color: subTextColor, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
