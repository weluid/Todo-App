part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class GetTaskListEvent extends TaskEvent {
  final int groupId;

  GetTaskListEvent(this.groupId);
}

// Add task to list
class AddTaskEvent extends TaskEvent {
  final String taskTitle;
  final int groupId;

  AddTaskEvent({required this.taskTitle, required this.groupId});
}

class RemoveTaskEvent extends TaskEvent {
  final int groupId;
  final int taskId;

  RemoveTaskEvent(this.groupId, this.taskId);
}

class ToggleMarkEvent extends TaskEvent {
  final int taskId;

  ToggleMarkEvent(this.taskId);
}

class RemoveGroupEvent extends TaskEvent {
  final int id;

  RemoveGroupEvent(this.id);
}

class RenameGroupEvent extends TaskEvent {
  final int id;
  final String newName;

  RenameGroupEvent({required this.id, required this.newName});
}

class ToggleImportant extends TaskEvent {
  final int taskId;

  ToggleImportant(this.taskId);
}

