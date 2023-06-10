part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class ToDoStartEvent extends TodoEvent {

}

// Add group to list
class AddGroupEvent extends TodoEvent {
  final String title;

  AddGroupEvent({required this.title});
}

//Add task to list
class AddTaskEvent extends TodoEvent {}
