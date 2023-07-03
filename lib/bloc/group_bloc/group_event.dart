part of 'group_bloc.dart';

@immutable
abstract class GroupEvent {}

class ToDoStartEvent extends GroupEvent {}

// Add group to list
class AddGroupEvent extends GroupEvent {
  final String title;

  AddGroupEvent({required this.title});
}