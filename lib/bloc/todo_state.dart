part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

// Add group to list
class AddGroup extends TodoState {}

//Add task to list
class AddTask extends TodoState {}

