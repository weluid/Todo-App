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
    on<GetUncompletedTasksEvent>(_eventGetUncompletedTask);
    on<AddTaskEvent>(_eventAddTask);
    on<ToggleImportantEvent>(_eventToggleImportant);
    on<RemoveTaskEvent>(_eventRemoveTask);
    on<ToggleMarkEvent>(_eventToggleMark);
    on<RemoveGroupEvent>(_eventRemoveGroup);
    on<RenameGroupEvent>(_eventRenameGroup);
    on<GetCompletedTaskEvent>(_eventCompletedTasks);
  }

  void _eventGetUncompletedTask(GetUncompletedTasksEvent e, Emitter emit) async {
   if(e.groupId =='2'){
     List<Task> allTasks = _toDoRepository.importantSampling();
     List<Task> unCompletedTasks = allTasks.where((task) => !task.isCompleted).toList();
     emit(GetTaskList(unCompletedTasks));
   } else{
     List<Task> allTasks = _toDoRepository.getTaskList(e.groupId);
     List<Task> unCompletedTasks = allTasks.where((task) => !task.isCompleted).toList();
     emit(GetTaskList(unCompletedTasks));
   }
  }

  FutureOr<void> _eventAddTask(AddTaskEvent e, Emitter<TaskState> emit) {
    if (e.groupId == '2') {
      _toDoRepository.addTask(
        Task(
            id: GetId().genIDByDatetimeNow(),
            isImportant: true,
            title: e.taskTitle,
            groupId: e.groupId,
            createdDate: DateTime.now()),
      );
      emit(GetTaskList(_toDoRepository.importantSampling()));
    } else {
      _toDoRepository.addTask(
        Task(id: GetId().genIDByDatetimeNow(), title: e.taskTitle, groupId: e.groupId, createdDate: DateTime.now()),
      );
      emit(GetTaskList(_toDoRepository.getTaskList(e.groupId)));
    }
  }

  FutureOr<void> _eventRemoveTask(RemoveTaskEvent e, Emitter<TaskState> emit) {
    _toDoRepository.removeTask(e.taskId);
    if (e.groupId == '2') {
      emit(GetTaskList(_toDoRepository.importantSampling()));
    } else {
      emit(GetTaskList(_toDoRepository.getTaskList(e.groupId)));
    }
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

  FutureOr<void> _eventToggleImportant(ToggleImportantEvent e, Emitter emit) {
    _toDoRepository.toggleImportant(e.taskId);
  }

  FutureOr<void> _eventCompletedTasks(GetCompletedTaskEvent e, Emitter emit) {
    if(e.groupId =='2'){
      List<Task> allTasks = _toDoRepository.importantSampling();
      List<Task> completedTasks = allTasks.where((task) => task.isCompleted).toList();
      emit(GetTaskList(completedTasks));
    } else{
      List<Task> allTasks = _toDoRepository.getTaskList(e.groupId);
      List<Task> completedTasks = allTasks.where((task) => task.isCompleted).toList();
      emit(GetTaskList(completedTasks));
    }

  }
}
