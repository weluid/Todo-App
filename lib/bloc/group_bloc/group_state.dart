part of 'group_bloc.dart';

@immutable
abstract class GroupState {}

class GroupInitial extends GroupState {}

class StartApp extends GroupState {
  final List<Group> groups;
  StartApp(this.groups);

}

// Add group to list
class AddGroup extends GroupState {}



