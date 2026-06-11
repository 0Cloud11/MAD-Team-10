import 'package:flutter/material.dart';
import '../models/program.dart';
import 'program_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;

    // Future-adaptable: Fetch featured programs from API
    final featuredProgram1 = Program(
      id: '1',
      title: 'ChatGPT-5 Mastery',
      startDate: 'July 15, 2026',
      description:
          'Master prompt engineering for ChatGPT-5. Learn to build advanced AI workflows.',
      schedule: 'Mon & Wed, 6:00 PM - 8:00 PM',
      eligibility: 'Basic understanding of AI concepts.',
      instructor: 'Dr. Alan Turing',
      rating: 4.8,
    );

    final featuredProgram2 = Program(
      id: '2',
      title: 'Gemini Ultra 2.0 Integration',
      startDate: 'August 01, 2026',
      description:
          'Learn multimodal integrations with Gemini. Text, image, and video processing.',
      schedule: 'Tue & Thu, 7:00 PM - 9:00 PM',
      eligibility: 'Intermediate Python programming.',
      instructor: 'Sarah Connor',
      rating: 4.9,
    );

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: themeColor,
            padding: const EdgeInsets.all(20),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WELCOME BACK,\nDEMO USER!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('DISCOVER THE LATEST AI TOOLS AND\nTHEIR COURSES!'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'LATEST AI LAUNCHES:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildCourseCard(context, featuredProgram1),
                _buildCourseCard(context, featuredProgram2),
              ],
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              program.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              program.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black54,
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
                child: const Text('CLICK HERE TO KNOW MORE!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
