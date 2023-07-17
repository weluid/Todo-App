part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class GetTaskListEvent extends TaskEvent {
  final String groupId;

  GetTaskListEvent(this.groupId);
}

// Add task to list
class AddTaskEvent extends TaskEvent {
  final String taskTitle;
  final String groupId;

  AddTaskEvent({required this.taskTitle, required this.groupId});
}

class RemoveTask extends TaskEvent {
  final String groupId;
  final String taskId;

  RemoveTask(this.groupId, this.taskId);
}

class ToggleMark extends TaskEvent {
  final String taskId;

  ToggleMark(this.taskId);
}

class RemoveGroup extends TaskEvent {
  final String id;

  RemoveGroup(this.id);
}

class RenameGroup extends TaskEvent {
  final String id;
  final String newName;

  RenameGroup({required this.id, required this.newName});
}

