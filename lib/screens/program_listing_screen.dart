import 'package:flutter/material.dart';
import '../models/program.dart';
import 'program_details_screen.dart';

class ProgramListingScreen extends StatefulWidget {
  const ProgramListingScreen({super.key});

  @override
  State<ProgramListingScreen> createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
  // Future-adaptable: This list can be populated from an API later
  final List<Program> _allPrograms = [
    Program(
      id: '1',
      title: 'ChatGPT-5 Mastery',
      startDate: 'July 15, 2026',
      description:
          'Master prompt engineering for ChatGPT-5. Learn to build advanced AI workflows.',
      schedule: 'Mon & Wed, 6:00 PM - 8:00 PM',
      eligibility: 'Basic understanding of AI concepts.',
      instructor: 'Dr. Alan Turing',
      rating: 4.8,
    ),
    Program(
      id: '2',
      title: 'Gemini Ultra 2.0 Integration',
      startDate: 'August 01, 2026',
      description:
          'Learn multimodal integrations with Gemini. Text, image, and video processing.',
      schedule: 'Tue & Thu, 7:00 PM - 9:00 PM',
      eligibility: 'Intermediate Python programming.',
      instructor: 'Sarah Connor',
      rating: 4.9,
    ),
    Program(
      id: '3',
      title: 'Claude 3 Opus Deep Dive',
      startDate: 'August 10, 2026',
      description:
          'Deep dive into Anthropic\'s best model for complex reasoning and analysis.',
      schedule: 'Weekends, 10:00 AM - 1:00 PM',
      eligibility: 'Advanced prompt engineering.',
      instructor: 'Dr. Emmett Brown',
      rating: 4.7,
    ),
  ];

  List<Program> _filteredPrograms = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredPrograms = _allPrograms;
    _searchController.addListener(_filterPrograms);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPrograms() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPrograms = _allPrograms.where((program) {
        return program.title.toLowerCase().contains(query) ||
            program.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;

    return SafeArea(
      child: Column(
        children: [
          Container(
            color: themeColor,
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: const Text(
              'HEY!\nHERE YOU CAN SEARCH ABOUT A PARTICULAR AI COURSE THAT YOU FIND AMUSING!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search programs...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: themeColor.withValues(alpha: 0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          Expanded(
            child: _filteredPrograms.isEmpty
                ? const Center(child: Text('No programs found.'))
                // Future-adaptable: ListView.builder is efficient for long API lists
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredPrograms.length,
                    itemBuilder: (context, index) {
                      return _buildCourseCard(
                        context,
                        _filteredPrograms[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Program program) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    program.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    Text(
                      program.rating.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Colors.black54,
                ),
                const SizedBox(width: 4),
                Text(
                  'Starts: ${program.startDate}',
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              program.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProgramDetailsScreen(program: program),
                    ),
                  );
                },
                child: const Text('View Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
