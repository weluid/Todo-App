part of 'task_extended_bloc.dart';

@immutable
abstract class TaskExtendedEvent {}

class GetTaskListEvent extends TaskExtendedEvent {
  final String groupId;

  GetTaskListEvent(this.groupId);
}

class RemoveTaskEvent extends TaskExtendedEvent {
  final String groupId;
  final String taskId;

  RemoveTaskEvent({required this.groupId, required this.taskId});
}

class AddDescriptionEvent extends TaskExtendedEvent {
  final String taskId;
  final String description;

  AddDescriptionEvent({required this.taskId, required this.description});
}

class ToggleMarkEvent extends TaskExtendedEvent {
  final String taskId;

  ToggleMarkEvent(this.taskId);
}

class ToggleImportantEvent extends TaskExtendedEvent {
  final String taskId;

  ToggleImportantEvent(this.taskId);
}

class AddDateEvent extends TaskExtendedEvent {
  final String taskId;
  final DateTime? date;

  AddDateEvent(this.taskId, this.date);
}

