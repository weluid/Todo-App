class Task {
  String id;
  String title;
  String description;
  bool isImportant;
  bool isCompleted;
  String groupId;

  Task({
    required this.id,
    required this.title,
    required this.groupId,
    this.description = '',
    this.isImportant = false,
    this.isCompleted = false,
  });

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, isImportant: $isImportant, isCompleted: $isCompleted, groupId: $groupId}';
  }
}
