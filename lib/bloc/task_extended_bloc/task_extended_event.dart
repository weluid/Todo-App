part of 'task_extended_bloc.dart';

@immutable
abstract class TaskExtendedEvent {}

class GetTaskListEvent extends TaskExtendedEvent {
  final String groupId;

  GetTaskListEvent(this.groupId);
}

class RemoveTask extends TaskExtendedEvent {
  final String groupId;
  final String taskId;

  RemoveTask({required this.groupId, required this.taskId});
}

class AddDescription extends TaskExtendedEvent {
  final String taskId;
  final String description;

  AddDescription({required this.taskId, required this.description});
}

class ToggleMark extends TaskExtendedEvent {
  final String taskId;

  ToggleMark(this.taskId);
}

class ToggleImportant extends TaskExtendedEvent {
  final String taskId;

  ToggleImportant(this.taskId);
}