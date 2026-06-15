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
}
