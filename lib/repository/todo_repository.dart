import 'package:flutter/material.dart';

import 'package:todo/models/group_model.dart';
import 'package:todo/models/task_model.dart';
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

  void removeGroup(String groupId){
    _manager.removeGroup(groupId);
  }
// get the list of groups
  List<Task> getTaskList(String id) {
    return _manager.getTaskList( id);
  }

  // add a group
  void addGroup(String title, String groupId) {
    _manager.addGroup(title, groupId);
    debugPrint(title.toString());
  }

  // add task to group
  void addTask( String taskTitle, String groupId, String taskId) {
    _manager.addTask( titleTask: taskTitle, groupId: groupId, taskId: taskId);
  }

  void removeTask(String groupID, String taskId) {
   _manager.removeTask(groupID, taskId);
  }
}
