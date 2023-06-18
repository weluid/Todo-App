import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/repository/todo_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ToDoRepository toDoRepository;

  TaskBloc(this.toDoRepository) : super(TaskInitial()) {
    on<GetTaskListEvent>(_eventGetTaskList);
    on<AddTaskEvent>(_eventAddTask);
  }

  void _eventGetTaskList(GetTaskListEvent e, Emitter emit) {
    emit(GetTaskList(toDoRepository.getTaskList(e.groupName)));
  }

  FutureOr<void> _eventAddTask(AddTaskEvent e, Emitter<TaskState> emit) {
    toDoRepository.addTask(e.groupName, e.taskTitle);
    emit(GetTaskList(toDoRepository.getTaskList(e.groupName)));
  }
}
