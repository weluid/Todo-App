import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/get_id.dart';
import 'package:todo/repository/todo_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ToDoRepository toDoRepository;

  TaskBloc(this.toDoRepository) : super(TaskInitial()) {
    on<GetTaskListEvent>(_eventGetTaskList);
    on<AddTaskEvent>(_eventAddTask);
    on<RemoveTask>(_eventRemoveTask);
    on<ToggleMark>(_eventToggleMark);
  }

  void _eventGetTaskList(GetTaskListEvent e, Emitter emit) {
    emit(GetTaskList(toDoRepository.getTaskList(e.groupId)));
  }

  FutureOr<void> _eventAddTask(AddTaskEvent e, Emitter<TaskState> emit) {
    toDoRepository.addTask(
      Task(id: GetId().genIDByDatetimeNow(), title: e.taskTitle, groupId: e.groupId),
    );
    emit(GetTaskList(toDoRepository.getTaskList(e.groupId)));
  }

  FutureOr<void> _eventRemoveTask(RemoveTask e, Emitter<TaskState> emit) {
    toDoRepository.removeTask(e.taskId);
    emit(GetTaskList(toDoRepository.getTaskList(e.groupId)));
  }

  FutureOr<void> _eventToggleMark(ToggleMark e, Emitter<TaskState> emit) {
    toDoRepository.toggleMark(e.taskId);
  }
}
