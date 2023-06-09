import 'package:todo/models/task_model.dart';

class Group {
  int? index;
  String title;
  List<Task> tasks;


  Group({this.index, required this.title, required this.tasks});

  @override
  String toString() {
    return 'GroupList{index: $index, title: $title, tasks: $tasks}';
  }
}
