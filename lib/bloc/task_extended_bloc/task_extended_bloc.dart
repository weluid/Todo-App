import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/todo_repository.dart';

part 'task_extended_event.dart';

part 'task_extended_state.dart';

class TaskExtendedBloc extends Bloc<TaskExtendedEvent, TaskExtendedState> {
  final ToDoRepository toDoRepository;

  TaskExtendedBloc(this.toDoRepository) : super(TaskExtendedInitial()) {
    on<AddDescription>(_eventAddDescription);
    on<RemoveTask>(_eventRemoveTask);
    on<GetTaskListEvent>(_eventGetTaskList);
    on<ToggleMark>(_eventToggleMark);
    on<ToggleImportant>(_eventToggleImportant);
  }

  FutureOr<void> _eventRemoveTask(RemoveTask e, Emitter emit) {
    toDoRepository.removeTask(e.taskId);
    emit(GetTaskList(toDoRepository.getTaskList(e.groupId)));
  }

  FutureOr<void> _eventAddDescription(AddDescription e, Emitter emit) {
    toDoRepository.addTaskDescription(e.taskId, e.description);
  }

  void _eventGetTaskList(GetTaskListEvent e, Emitter emit) {
    emit(GetTaskList(toDoRepository.getTaskList(e.groupId)));
  }

  FutureOr<void> _eventToggleMark(ToggleMark e, Emitter emit) {
    toDoRepository.toggleMark(e.taskId);
  }

  FutureOr<void> _eventToggleImportant(ToggleImportant e, Emitter emit) {
    toDoRepository.toggleImportant(e.taskId);
  }
}
