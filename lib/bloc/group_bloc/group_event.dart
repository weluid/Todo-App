part of 'group_bloc.dart';

@immutable
abstract class GroupEvent {}

class ToDoStartEvent extends GroupEvent {}

// Add group to list
class AddGroupEvent extends GroupEvent {
  final String title;

  AddGroupEvent({required this.title});
}

// Remove group
class RemoveGroup extends GroupEvent {
  final String id;

  RemoveGroup(this.id);
}
