import 'package:flutter/material.dart';
import '../models/program.dart';
import 'program_details_screen.dart';

class ProgramListingScreen extends StatefulWidget {
  const ProgramListingScreen({super.key});

  @override
  State<ProgramListingScreen> createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
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

  void _openProgramDetails(Program program) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProgramDetailsScreen(),
        settings: RouteSettings(arguments: program),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Program Listing',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: themeColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            color: themeColor,
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: const Text(
              'Browse available programs and view full details.',
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
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredPrograms.length,
              itemBuilder: (context, index) {
                final program = _filteredPrograms[index];
                return Card(
                  color: themeColor,
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          program.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start Date: ${program.startDate}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          program.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _openProgramDetails(program),
                            child: const Text('View Details'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
