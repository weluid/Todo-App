import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/group.dart';
import 'package:todo/repository/todo_repository.dart';

part 'group_event.dart';

part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final ToDoRepository toDoRepository;

  GroupBloc(this.toDoRepository) : super(GroupInitial()) {
    on<ToDoStartEvent>(_eventStartApp);
    on<AddGroupEvent>(_eventAddGroup);
    on<RemoveGroup>(_eventRemoveGroup);
    on<RenameGroup>(_eventRenameGroup);
  }

  Future<void> _eventStartApp(GroupEvent e, Emitter emit) async {
    emit(StartApp(toDoRepository.getGroupList()));
  }

  void _eventAddGroup(AddGroupEvent e, Emitter emit) {
    toDoRepository.addGroup(e.title);

    emit(StartApp(toDoRepository.getGroupList()));
  }

  FutureOr<void> _eventRemoveGroup(RemoveGroup e, Emitter emit) {
    toDoRepository.removeGroup(e.id);
    emit(StartApp(toDoRepository.getGroupList()));
  }

  FutureOr<void> _eventRenameGroup(RenameGroup e, Emitter<GroupState> emit) {
    toDoRepository.renameGroup(e.id, e.newName);
    emit(StartApp(toDoRepository.getGroupList()));
  }
}
