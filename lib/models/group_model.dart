import 'package:todo/models/task_model.dart';

class Group {
  // String id;
  String title;
  List<Task> tasks;

  Group({

    required this.title,
    required this.tasks,
  });

  @override
  String toString() {
    return 'GroupList{title: $title, tasks: $tasks}';
  }
}
