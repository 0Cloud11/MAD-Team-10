import 'package:flutter/material.dart';
import '../models/program.dart';

class ProgramListingScreen extends StatefulWidget {
  final bool showAppBar;

  const ProgramListingScreen({super.key, this.showAppBar = false});

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
    Navigator.pushNamed(context, '/program-details', arguments: program);
  }

  Widget _buildBody(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final subTextColor = isDark ? Colors.white70 : const Color(0xFF4B5563);

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Theme.of(context).cardColor,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
          child: Text(
            'Browse programs, review summaries, and open full details for each opportunity.',
            style: TextStyle(fontSize: 14, color: subTextColor, height: 1.4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search programs',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: _filteredPrograms.isEmpty
              ? Center(
                  child: Text(
                    'No programs found.',
                    style: TextStyle(fontSize: 16, color: textColor),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _filteredPrograms.length,
                  itemBuilder: (context, index) {
                    final program = _filteredPrograms[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isDark
                                ? Colors.transparent
                                : const Color(0xFFF1D3BE),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                program.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_rounded,
                                    size: 18,
                                    color: primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Start Date: ${program.startDate}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: subTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                program.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: subTextColor,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => _openProgramDetails(program),
                                child: const Text('View Details'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showAppBar) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Program Listing'),
          automaticallyImplyLeading: true,
        ),
        body: _buildBody(context),
      );
    }
    return SafeArea(child: _buildBody(context));
  }
}
