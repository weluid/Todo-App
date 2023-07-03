import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/group_model.dart';
import 'package:todo/repository/get_id.dart';
import 'package:todo/repository/todo_repository.dart';

part 'group_event.dart';

part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final ToDoRepository toDoRepository;

  GroupBloc(this.toDoRepository) : super(GroupInitial()) {
    on<ToDoStartEvent>(_eventStartApp);
    on<AddGroupEvent>(_eventAddGroup);
    on<RemoveGroup>(_eventRemoveGroup);
  }

  Future<void> _eventStartApp(GroupEvent e, Emitter emit) async {
    emit(StartApp(toDoRepository.getGroupList()));
  }

  void _eventAddGroup(AddGroupEvent e, Emitter emit) {
    toDoRepository.addGroup(e.title, GetId().genIDByDatetimeNow());

    emit(StartApp(toDoRepository.getGroupList()));
  }

  FutureOr<void> _eventRemoveGroup(RemoveGroup e, Emitter emit) {
    toDoRepository.removeGroup(e.id);
    emit(StartApp(toDoRepository.getGroupList()));
  }
}
