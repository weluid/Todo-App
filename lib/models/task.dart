class Task {
  int id;
  String title;
  String description;
  bool isImportant;
  bool isCompleted;
  int groupId;
  DateTime? dueDate;
  DateTime createdDate;

  Task({
    required this.id,
    required this.title,
    required this.groupId,
    this.description = '',
    this.isImportant = false,
    this.isCompleted = false,
    this.dueDate,
    required this.createdDate,
  });

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, isImportant: $isImportant, isCompleted: $isCompleted, groupId: $groupId, dueDate: $dueDate, createdDate: $createdDate}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isImportant': isImportant ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
      'groupId': groupId,
      'dueDate': dueDate?.toIso8601String(),
      'createdDate': createdDate.toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isImportant: json['isImportant'] == 1,
      isCompleted: json['isCompleted'] == 1,
      groupId: json['groupId'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      createdDate: DateTime.parse(json['createdDate']),
    );
  }
}
