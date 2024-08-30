// lib/models/assignment_model.dart

class Assignment {
  final String title;
  final DateTime dueDate;
  final String description;

  Assignment({
    required this.title,
    required this.dueDate,
    required this.description,
  });

  // Factory method to create an Assignment from a Map (for example, from JSON)
  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      title: map['title'],
      dueDate: DateTime.parse(map['dueDate']),
      description: map['description'],
    );
  }

  // Method to convert an Assignment to a Map (for example, to JSON)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'dueDate': dueDate.toIso8601String(),
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Assignment(title: $title, dueDate: $dueDate, description: $description)';
  }
}
