class Task {
  String id;
  String title;
  String description;
  bool isImportant;
  bool isCompleted;
  String groupId;
  DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    required this.groupId,
    this.description = '',
    this.isImportant = false,
    this.isCompleted = false,
    this.dueDate,
  });

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, isImportant: $isImportant, isCompleted: $isCompleted, groupId: $groupId, dueDate: $dueDate}';
  }
}
