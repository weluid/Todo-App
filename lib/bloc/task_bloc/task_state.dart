part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

//Add task to list
class AddTask extends TaskState {}

//Get task to list
class GetTaskList extends TaskState {
  final List<Task> taskList;

  GetTaskList(this.taskList);
}

class GetTasksList extends TaskState {
  final List<Task> taskList;

  GetTasksList(this.taskList);
}
