import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _commentsController = TextEditingController();

  String? _selectedCategory;
  bool _isSubmitting = false;

  final List<String> _categories = [
    'General App Feedback',
    'Course Suggestion',
    'Report a Bug',
    'Instructor Help',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    // Simulate API form submission delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you, your feedback was submitted!'),
        backgroundColor: Colors.green,
      ),
    );

    // Clear form to reflect dynamic state update
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _commentsController.clear();
    setState(() {
      _selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We Value Your Feedback',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please let us know how we can improve your learning experience.',
                style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.4),
              ),
              const SizedBox(height: 30),

              const Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Enter your name'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Name is required'
                    : null,
              ),
              const SizedBox(height: 20),

              const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Enter your email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return 'Email is required';
                  if (!value.contains('@'))
                    return 'Enter a valid email containing "@"';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              const Text(
                'Feedback Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  hintText: 'Select a category',
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedCategory = val),
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
              ),
              const SizedBox(height: 20),

              const Text(
                'Comments',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _commentsController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Share your thoughts here...',
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Comments are required'
                    : null,
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitFeedback,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text('Submit Feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
