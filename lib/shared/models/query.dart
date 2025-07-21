class QueryResponse {
  final String by;
  final String message;
  final String time;

  QueryResponse({required this.by, required this.message, required this.time});

  factory QueryResponse.fromJson(Map<String, dynamic> json) {
    return QueryResponse(
      by: json['by'],
      message: json['message'],
      time: json['time'],
    );
  }
}

class SupportQuery {
  final String id;
  final String student;
  final String category;
  final String status;
  final String priority;
  final String question;
  final List<QueryResponse> responses;

  SupportQuery({
    required this.id,
    required this.student,
    required this.category,
    required this.status,
    required this.priority,
    required this.question,
    required this.responses,
  });

  factory SupportQuery.fromJson(Map<String, dynamic> json) {
    return SupportQuery(
      id: json['id'],
      student: json['student'],
      category: json['category'],
      status: json['status'],
      priority: json['priority'],
      question: json['question'],
      responses: (json['responses'] as List<dynamic>?)?.map((e) => QueryResponse.fromJson(e)).toList() ?? [],
    );
  }
} 