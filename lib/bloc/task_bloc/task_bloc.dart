import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/get_id.dart';
import 'package:todo/repository/todo_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ToDoRepository _toDoRepository;

  TaskBloc(this._toDoRepository) : super(TaskInitial()) {
    on<GetTaskListEvent>(_eventGetTaskList);
    on<AddTaskEvent>(_eventAddTask);
    on<ToggleImportant>(_eventToggleImportant);
    on<RemoveTaskEvent>(_eventRemoveTask);
    on<ToggleMarkEvent>(_eventToggleMark);
    on<RemoveGroupEvent>(_eventRemoveGroup);
    on<RenameGroupEvent>(_eventRenameGroup);
  }

  void _eventGetTaskList(GetTaskListEvent e, Emitter emit) {
    emit(GetTaskList(_toDoRepository.getTaskList(e.groupId)));
  }

  FutureOr<void> _eventAddTask(AddTaskEvent e, Emitter<TaskState> emit) {
    _toDoRepository.addTask(
      Task(id: GetId().genIDByDatetimeNow(), title: e.taskTitle, groupId: e.groupId, createdDate: DateTime.now()),
    );
    emit(GetTaskList(_toDoRepository.getTaskList(e.groupId)));
  }

  FutureOr<void> _eventRemoveTask(RemoveTaskEvent e, Emitter<TaskState> emit) {
    _toDoRepository.removeTask(e.taskId);
    emit(GetTaskList(_toDoRepository.getTaskList(e.groupId)));
  }

  FutureOr<void> _eventToggleMark(ToggleMarkEvent e, Emitter<TaskState> emit) {
    _toDoRepository.toggleMark(e.taskId);
  }

  FutureOr<void> _eventRemoveGroup(RemoveGroupEvent e, Emitter emit) {
    _toDoRepository.removeGroup(e.id);
  }

  FutureOr<void> _eventRenameGroup(RenameGroupEvent e, Emitter emit) {
    _toDoRepository.renameGroup(e.id, e.newName);
  }

  FutureOr<void> _eventToggleImportant(ToggleImportant e, Emitter emit) {
    _toDoRepository.toggleImportant(e.taskId);
  }
}
