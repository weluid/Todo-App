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

// Rename group
class RenameGroup extends GroupEvent {
  final String id;
  final String newName;

  RenameGroup({required this.id, required this.newName});
}
