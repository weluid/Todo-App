import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/group_model.dart';
import 'package:todo/repository/list_management%20.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(ToDoInitial()) {
    // on<TodoEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<ToDoStartEvent>(_eventHandler);
    on<AddGroupEvent>(_eventAddGroup);
  }

  Future<void> _eventHandler(TodoEvent e, Emitter emit) async {
    emit(StartApp(ListManagement().groupList));
  }

  Future<void> _eventAddGroup(AddGroupEvent e, Emitter emit) async {
    await ListManagement().addGroup(e.title);

    emit(StartApp(ListManagement().groupList));
  }
}
