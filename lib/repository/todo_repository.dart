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
  List<Group> getGroupList() {
    return _manager.getGroupList();
  }

  void removeGroup(String groupId) {
    _manager.removeGroup(groupId);
  }

// get the list of groups
  List<Task> getTaskList(String id) {
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
  void removeTask(String taskId) {
    _manager.removeTask(taskId);
  }

  // toggle the task checkbox
  void toggleMark(String taskID) {
    _manager.toggleMark(taskID);
  }

  // rename group
  void renameGroup(String id, String newName) {
    _manager.renameGroup(id, newName);
  }

  void addTaskDescription(String taskId, String description) {
    _manager.addTaskDescription(taskId, description);
  }

  void toggleImportant(String taskId) {
    _manager.toggleImportant(taskId);
  }

  void addDate(String taskId, DateTime date) {
    _manager.addDate(taskId, date);
  }
}
