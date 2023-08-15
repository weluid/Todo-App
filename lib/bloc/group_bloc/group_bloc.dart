import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/group.dart';
import 'package:todo/repository/todo_repository.dart';

part 'group_event.dart';

part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final ToDoRepository _toDoRepository;

  GroupBloc(this._toDoRepository) : super(GroupInitial()) {
    on<InitializationEvent>(_eventStartApp);
    on<AddGroupEvent>(_eventAddGroup);
    on<RemoveGroupEvent>(_eventRemoveGroup);
    on<RenameGroupEvent>(_eventRenameGroup);
  }

  Future<void> _eventStartApp(GroupEvent e, Emitter emit) async {
    emit(InitializationApp(await _toDoRepository.getGroupList()));
  }

  void _eventAddGroup(AddGroupEvent e, Emitter emit) async {
    _toDoRepository.addGroup(e.title);

    emit(InitializationApp(await _toDoRepository.getGroupList()));
  }

  FutureOr<void> _eventRemoveGroup(RemoveGroupEvent e, Emitter emit)async {
    _toDoRepository.removeGroup(e.id);
    emit(InitializationApp(await _toDoRepository.getGroupList()));
  }

  FutureOr<void> _eventRenameGroup(RenameGroupEvent e, Emitter<GroupState> emit) async {
    _toDoRepository.renameGroup(e.id, e.newName);
    emit(InitializationApp(await _toDoRepository.getGroupList()));
  }
}
