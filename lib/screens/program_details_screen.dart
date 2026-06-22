import 'package:flutter/material.dart';
import '../models/program.dart';

class ProgramDetailsScreen extends StatefulWidget {
  const ProgramDetailsScreen({super.key});

  @override
  State<ProgramDetailsScreen> createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen> {
  void _showRegistrationDialog(BuildContext context, Program program) {
    final formKey = GlobalKey<FormState>();
    final reasonController = TextEditingController();
    bool isSubmitting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Container(
                width: 500,
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Register for Program',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'You are registering for ${program.title}. Please provide a brief reason for joining.',
                          style: const TextStyle(
                            color: Colors.grey,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Why do you want to join?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: reasonController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'Enter your reason...',
                          ),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? 'Reason is required to register'
                              : null,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: isSubmitting
                                    ? null
                                    : () => Navigator.pop(dialogContext),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: isSubmitting
                                    ? null
                                    : () async {
                                        if (!formKey.currentState!.validate())
                                          return;

                                        setDialogState(() {
                                          isSubmitting = true;
                                        });
                                        await Future.delayed(
                                          const Duration(seconds: 2),
                                        ); // Simulate API Post

                                        if (!dialogContext.mounted) return;
                                        Navigator.pop(
                                          dialogContext,
                                        ); // Close dialog

                                        ScaffoldMessenger.of(
                                          this.context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Successfully registered for ${program.title}!',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      },
                                child: isSubmitting
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Confirm'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final Program program = args as Program;
    final primary = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Program Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF232833)
                      : const Color(0xFFF1D3BE),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: primary),
                      const SizedBox(width: 6),
                      Text(
                        '${program.rating} Rating',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              title: 'Description',
              value: program.description,
            ),
            _buildSection(
              context,
              title: 'Start Date',
              value: program.startDate,
            ),
            _buildSection(context, title: 'Schedule', value: program.schedule),
            _buildSection(
              context,
              title: 'Eligibility',
              value: program.eligibility,
            ),
            _buildSection(
              context,
              title: 'Instructor',
              value: program.instructor,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _showRegistrationDialog(context, program),
              child: const Text('Enroll Now'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? const Color(0xFF232833) : const Color(0xFFF1D3BE),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 14, height: 1.4)),
        ],
      ),
    );
  }
}
