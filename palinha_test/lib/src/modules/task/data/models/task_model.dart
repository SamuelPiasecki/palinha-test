class Task {
  final String? id;
  final String title;
  final String description;
  final String priority;
  final String dueDate;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      dueDate: map['dueDate'],
    );
  }
}
