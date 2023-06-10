part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class ToDoInitial extends TodoState {}

class StartApp extends TodoState {
  final List<Group> groups;

  StartApp(this.groups);
}


// Add group to list
class AddGroup extends TodoState {}

//Add task to list
class AddTask extends TodoState {}


class AddGroupSuccess extends TodoState {}