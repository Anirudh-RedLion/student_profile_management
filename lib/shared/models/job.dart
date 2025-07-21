class Job {
  final String id;
  final String title;
  final String company;
  final String salary;
  final List<String> requirements;
  final String description;
  final String status;
  final String location;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.salary,
    required this.requirements,
    required this.description,
    required this.status,
    required this.location,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      company: json['company'],
      salary: json['salary'],
      requirements: List<String>.from(json['requirements'] ?? []),
      description: json['description'],
      status: json['status'],
      location: json['location'],
    );
  }
} 