import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/group_model.dart';
import 'package:todo/repository/get_id.dart';
import 'package:todo/repository/todo_repository.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final ToDoRepository toDoRepository;

  ToDoBloc(this.toDoRepository) : super(ToDoInitial()) {
    on<ToDoStartEvent>(_eventHandler);
    on<AddGroupEvent>(_eventAddGroup);
  }

  Future<void> _eventHandler(ToDoEvent e, Emitter emit) async {
    emit(StartApp(toDoRepository.getGroupList()));
  }

  void _eventAddGroup(AddGroupEvent e, Emitter emit) {
    toDoRepository.addGroup(e.title, GetId().genIDByDatetimeNow());

    emit(StartApp(toDoRepository.getGroupList()));
  }
}
