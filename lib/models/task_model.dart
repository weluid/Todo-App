class Task{
  String title;
  String? description;
  String? id;
  bool? isImportant;

  Task({required this.title, this.description, this.id, this.isImportant});

  @override
  String toString() {
    return 'Task{title: $title, description: $description, id: $id}';
  }
}