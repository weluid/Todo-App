import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/todo_repository.dart';

part 'task_extended_event.dart';

part 'task_extended_state.dart';

class TaskExtendedBloc extends Bloc<TaskExtendedEvent, TaskExtendedState> {
  final ToDoRepository _toDoRepository;

  TaskExtendedBloc(this._toDoRepository) : super(TaskExtendedInitial()) {
    on<AddDescriptionEvent>(_eventAddDescription);
    on<RemoveTaskEvent>(_eventRemoveTask);
    on<GetTaskListEvent>(_eventGetTaskList);
    on<ToggleMark>(_eventToggleMark);
    on<ToggleImportant>(_eventToggleImportant);
    on<AddDate>(_eventAddDate);
  }

  FutureOr<void> _eventRemoveTask(RemoveTaskEvent e, Emitter emit) {
    _toDoRepository.removeTask(e.taskId);
    emit(GetTaskList(_toDoRepository.getTaskList(e.groupId)));
  }

  FutureOr<void> _eventAddDescription(AddDescriptionEvent e, Emitter emit) {
    _toDoRepository.addTaskDescription(e.taskId, e.description);
  }

  void _eventGetTaskList(GetTaskListEvent e, Emitter emit) {
    emit(GetTaskList(_toDoRepository.getTaskList(e.groupId)));
  }

  FutureOr<void> _eventToggleMark(ToggleMark e, Emitter<TaskExtendedState> emit) {
    toDoRepository.toggleMark(e.taskId);
  }

  FutureOr<void> _eventToggleImportant(ToggleImportant e, Emitter<TaskExtendedState> emit) {
    toDoRepository.toggleImportant(e.taskId);
  }

  FutureOr<void> _eventAddDate(AddDate e, Emitter<TaskExtendedState> emit) {
    toDoRepository.addDate(e.taskId, e.date);
  }
}
