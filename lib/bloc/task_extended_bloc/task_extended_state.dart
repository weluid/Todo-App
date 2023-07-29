part of 'task_extended_bloc.dart';

@immutable
abstract class TaskExtendedState {}

class TaskExtendedInitial extends TaskExtendedState {}

//Add task to list
class AddTask extends TaskExtendedState {}

//Get task to list
class GetTaskList extends TaskExtendedState {
  final List<Task> taskList;

  GetTaskList(this.taskList);
}
