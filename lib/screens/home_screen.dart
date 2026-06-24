import 'package:flutter/material.dart';
import '../models/program.dart';
import '../services/user_prefs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = 'Learner';
  late Future<List<Program>> _featuredProgramsFuture;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _featuredProgramsFuture = Program.fetchPrograms().then(
      (list) => list.take(2).toList(),
    );
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
    final brandOrange = Theme.of(context).colorScheme.primary;
    final brandPink = Theme.of(context).colorScheme.secondary;
    final brandDark = Theme.of(context).colorScheme.tertiary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? const Color(0xFF2D3340)
        : const Color(0xFFF1D3BE);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.auto_awesome_rounded, color: Color(0xFFFB923C)),
                SizedBox(width: 8),
                Text(
                  'Excelerate',
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
                  colors: [brandDark, brandPink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, $username',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Explore programs, discover opportunities, and continue your Excelerate journey.',
                    style: TextStyle(
                      color: Color(0xFFF5F5F5),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: 210,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        DefaultTabController.of(context);
                      },
                      icon: const Icon(Icons.school_rounded),
                      label: const Text('Explore Programs'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandOrange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Featured AI Programs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
            FutureBuilder<List<Program>>(
              future: _featuredProgramsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFB923C),
                      ),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor),
                    ),
                    child: const Text(
                      'Failed to load featured programs.',
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }

                final programs = snapshot.data ?? [];

                return Column(
                  children: programs
                      .map((program) => _buildFeaturedCard(context, program))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(BuildContext context, Program program) {
    final brandOrange = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? const Color(0xFF2D3340)
        : const Color(0xFFF1D3BE);

    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: borderColor),
      ),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.pushNamed(context, '/program-details', arguments: program);
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  color: brandOrange.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.psychology_alt_rounded,
                  color: brandOrange,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      program.startDate,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: brandOrange),
            ],
          ),
        ),
      ),
    );
  }
}
