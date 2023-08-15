part of 'task_extended_bloc.dart';

@immutable
abstract class TaskExtendedEvent {}

class GetTaskListEvent extends TaskExtendedEvent {
  final int groupId;

  GetTaskListEvent(this.groupId);
}

class RemoveTaskEvent extends TaskExtendedEvent {
  final int groupId;
  final int taskId;

  RemoveTaskEvent({required this.groupId, required this.taskId});
}

class AddDescriptionEvent extends TaskExtendedEvent {
  final int taskId;
  final String description;

  AddDescriptionEvent({required this.taskId, required this.description});
}

class ToggleMarkEvent extends TaskExtendedEvent {
  final int taskId;

  ToggleMarkEvent(this.taskId);
}

class ToggleImportantEvent extends TaskExtendedEvent {
  final int taskId;

  ToggleImportantEvent(this.taskId);
}

class AddDateEvent extends TaskExtendedEvent {
  final int taskId;
  final DateTime? date;

  AddDateEvent(this.taskId, this.date);
}

