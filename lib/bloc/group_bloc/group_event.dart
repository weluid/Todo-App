part of 'group_bloc.dart';

@immutable
abstract class GroupEvent {}

class InitializationEvent extends GroupEvent {}

// Add group to list
class AddGroupEvent extends GroupEvent {
  final String title;

  AddGroupEvent({required this.title});
}

// Remove group
class RemoveGroupEvent extends GroupEvent {
  final int id;

  RemoveGroupEvent(this.id);
}

// Rename group
class RenameGroupEvent extends GroupEvent {
  final int id;
  final String newName;

  RenameGroupEvent({required this.id, required this.newName});
}
