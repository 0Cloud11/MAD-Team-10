import 'package:flutter/material.dart';
import 'program_details_screen.dart';

class ProgramListingScreen extends StatelessWidget {
  const ProgramListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;

    return SafeArea(
      child: Column(
        children: [
          Container(
            color: themeColor,
            padding: const EdgeInsets.all(20),
            child: const Text(
              'HEY!\nHERE YOU CAN SEARCH ABOUT A PARTICULAR AI COURSE THAT YOU FIND AMUSING!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'SEARCH',
                filled: true,
                fillColor: themeColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildCourseCard(
                  context,
                  'CHATGPT-5',
                  'Master prompt engineering for ChatGPT-5.',
                ),
                _buildCourseCard(
                  context,
                  'GEMINI ULTRA 2.0',
                  'Learn multimodal integrations with Gemini.',
                ),
                _buildCourseCard(
                  context,
                  'CLAUDE 3 OPUS',
                  'Deep dive into Anthropic\'s best model.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context,
    String title,
    String description,
  ) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text('..........'),
            const SizedBox(height: 15),
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
                      builder: (context) => ProgramDetailsScreen(
                        title: title,
                        description: description,
                      ),
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
