part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}


class GetTaskListEvent extends TaskEvent {
  final String groupName;

  GetTaskListEvent(this.groupName);
}

//Add task to list
class AddTaskEvent extends TaskEvent {}

