class Program {
  final String id;
  final String title;
  final String startDate;
  final String description;
  final String schedule;
  final String eligibility;
  final String instructor;
  final double rating;

  Program({
    required this.id,
    required this.title,
    required this.startDate,
    required this.description,
    required this.schedule,
    required this.eligibility,
    required this.instructor,
    required this.rating,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      startDate: json['startDate'] ?? '',
      description: json['description'] ?? '',
      schedule: json['schedule'] ?? '',
      eligibility: json['eligibility'] ?? '',
      instructor: json['instructor'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate,
      'description': description,
      'schedule': schedule,
      'eligibility': eligibility,
      'instructor': instructor,
      'rating': rating,
    };
  }

  // --- MOCK API DATA HANDLING ---
  // Simulates fetching JSON data from an external API with network latency
  static Future<List<Program>> fetchPrograms() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulating network load

    // Simulate a random network error (uncomment to test error handling)
    // if (DateTime.now().second % 5 == 0) throw Exception("Network Timeout");

    final List<Map<String, dynamic>> mockJsonData = [
      {
        'id': '1',
        'title': 'ChatGPT-5 Mastery',
        'startDate': 'July 15, 2026',
        'description':
            'Master prompt engineering for ChatGPT-5. Learn to build advanced AI workflows.',
        'schedule': 'Mon & Wed, 6:00 PM - 8:00 PM',
        'eligibility': 'Basic understanding of AI concepts.',
        'instructor': 'Dr. Alan Turing',
        'rating': 4.8,
      },
      {
        'id': '2',
        'title': 'Gemini Ultra 2.0 Integration',
        'startDate': 'August 01, 2026',
        'description':
            'Learn multimodal integrations with Gemini. Text, image, and video processing.',
        'schedule': 'Tue & Thu, 7:00 PM - 9:00 PM',
        'eligibility': 'Intermediate Python programming.',
        'instructor': 'Sarah Connor',
        'rating': 4.9,
      },
      {
        'id': '3',
        'title': 'Claude 3 Opus Deep Dive',
        'startDate': 'August 10, 2026',
        'description':
            'Deep dive into Anthropic\'s best model for complex reasoning and analysis.',
        'schedule': 'Weekends, 10:00 AM - 1:00 PM',
        'eligibility': 'Advanced prompt engineering.',
        'instructor': 'Dr. Emmett Brown',
        'rating': 4.7,
      },
      {
        'id': '4',
        'title': 'Applied Machine Learning',
        'startDate': 'September 05, 2026',
        'description':
            'End-to-end machine learning pipelines. From data prep to deployment.',
        'schedule': 'Fri, 5:00 PM - 8:00 PM',
        'eligibility': 'Advanced Python & Math.',
        'instructor': 'Ada Lovelace',
        'rating': 4.6,
      },
    ];

    return mockJsonData.map((json) => Program.fromJson(json)).toList();
  }
}
