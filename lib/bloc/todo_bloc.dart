import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/group_model.dart';
import 'package:todo/repository/get_id.dart';
import 'package:todo/repository/todo_repository.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(ToDoInitial()) {
    on<ToDoStartEvent>(_eventHandler);
    on<AddGroupEvent>(_eventAddGroup);
  }

  Future<void> _eventHandler(TodoEvent e, Emitter emit) async {
    emit(StartApp(todoRepository.getGroupList()));
  }

  void _eventAddGroup(AddGroupEvent e, Emitter emit) {
    todoRepository.addGroup(e.title, GetId().genIDByDatetimeNow());

    emit(StartApp(todoRepository.getGroupList()));
  }
}
