import 'package:flutter/material.dart';

import 'package:todo/models/group.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/database/base_database.dart';

class ToDoRepository {
  final BaseDatabase _manager;
  static ToDoRepository? _instance;

  ToDoRepository._privateConstructor(this._manager);

  static ToDoRepository getInstance(BaseDatabase dataManager) {
    _instance ??= ToDoRepository._privateConstructor(dataManager);
    return _instance!;
  }

  // get the list of groups
  Future<List<Group>> getGroupList() {
    return _manager.getGroupList();
  }

  void removeGroup(int groupId) {
    _manager.removeGroup(groupId);
  }

// get the list of groups
  Future<List<Task>> getTaskList(int id) {
    return _manager.getTaskList(id);
  }

  // add a group
  void addGroup(String title) {
    _manager.addGroup(title);
    debugPrint(title.toString());
  }

  // add task to group
  void addTask(Task task) {
    _manager.addTask(task);
  }

  // remove task
  void removeTask(int taskId) {
    _manager.removeTask(taskId);
  }

  // toggle the task checkbox
  void toggleMark(int taskID) {
    _manager.toggleMark(taskID);
  }

  // rename group
  void renameGroup(int id, String newName) {
    _manager.renameGroup(id, newName);
  }

  void addTaskDescription(int taskId, String description) {
    _manager.addTaskDescription(taskId, description);
  }

  void toggleImportant(int taskId) {
    _manager.toggleImportant(taskId);
  }

  void addDate(int taskId, DateTime? date) {
    _manager.addDate(taskId, date);
  }

  Future<List<Task>> importantSampling() {
  return _manager.importantSampling();
  }

}
