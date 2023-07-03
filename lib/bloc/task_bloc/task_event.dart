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
  final String taskId;

  AddTaskEvent({required this.taskTitle, required this.groupId, required this.taskId});
}

// Remove task
class RemoveTask extends TaskEvent {
  final String groupId;
  final String taskId;

  RemoveTask(this.groupId, this.taskId);
}
