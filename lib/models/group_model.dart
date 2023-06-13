import 'package:todo/models/task_model.dart';

class Group {
  String id;
  String title;
  List<Task> tasks;

  Group({
    required this.title,
    required this.tasks,
    required this.id
  });

  @override
  String toString() {
    return 'Group{id: $id, title: $title, tasks: $tasks}';
  }
}
