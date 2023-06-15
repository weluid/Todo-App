class Task{
  String title;
  String? description;
  String? id;
  bool? isImportant;
  bool isCompleted;

  Task({required this.title, this.description, this.id, this.isImportant, required this.isCompleted});

  @override
  String toString() {
    return 'Task{title: $title, description: $description, id: $id, isImportant: $isImportant, isCompleted: $isCompleted}';
  }
}