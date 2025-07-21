class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String domain;
  final double progress;
  final List<String> materials;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.domain,
    required this.progress,
    required this.materials,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      instructor: json['instructor'],
      domain: json['domain'],
      progress: (json['progress'] as num).toDouble(),
      materials: List<String>.from(json['materials'] ?? []),
    );
  }
} 