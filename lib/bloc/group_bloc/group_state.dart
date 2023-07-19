part of 'group_bloc.dart';

@immutable
abstract class GroupState {}

class GroupInitial extends GroupState {}

class InitializationApp extends GroupState {
  final List<Group> groups;

  InitializationApp(this.groups);
}

// Add group to list
class AddGroup extends GroupState {}
