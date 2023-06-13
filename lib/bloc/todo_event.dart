part of 'todo_bloc.dart';

@immutable
abstract class ToDoEvent {}

class ToDoStartEvent extends ToDoEvent {}

// Add group to list
class AddGroupEvent extends ToDoEvent {
  final String title;
  AddGroupEvent({required this.title});
}

//Add task to list
class AddTaskEvent extends ToDoEvent {}
