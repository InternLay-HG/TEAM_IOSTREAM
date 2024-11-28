class Assignment {
  final String? id;
  String title;
  String description;
  DateTime dueDate;
  String file;
  String professorId;
  final String professorName;
  final DateTime? createdAt;

  Assignment({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.file,
    required this.professorId,
    required this.professorName,
    this.createdAt,
  });

  // Convert from JSON to Assignment
  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      file: json['file'],
      dueDate: DateTime.parse(json['dueDate']),
      professorId: json['professorId']['_id'],
      professorName: json['professorId']['name'],
    );
  }
}
