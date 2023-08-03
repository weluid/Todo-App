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

class RemoveTaskEvent extends TaskEvent {
  final String groupId;
  final String taskId;

  RemoveTaskEvent(this.groupId, this.taskId);
}

class ToggleMarkEvent extends TaskEvent {
  final String taskId;

  ToggleMarkEvent(this.taskId);
}

class RemoveGroupEvent extends TaskEvent {
  final String id;

  RemoveGroupEvent(this.id);
}

class RenameGroupEvent extends TaskEvent {
  final String id;
  final String newName;

  RenameGroupEvent({required this.id, required this.newName});
}

class ToggleImportant extends TaskEvent {
  final String taskId;

  ToggleImportant(this.taskId);
}

