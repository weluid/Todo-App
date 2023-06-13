part of 'todo_bloc.dart';

@immutable
abstract class ToDoState {}

class ToDoInitial extends ToDoState {}

class StartApp extends ToDoState {
  final List<Group> groups;
  StartApp(this.groups);

}

// Add group to list
class AddGroup extends ToDoState {}

//Add task to list
class AddTask extends ToDoState {}


