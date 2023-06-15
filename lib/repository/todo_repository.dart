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

// get the list of groups
  List<Task> getTaskList(String groupName) {
    return _manager.getTaskList(groupName);
  }

  // add a group
  void addGroup(String title, String id) {
    _manager.addGroup(title, id);
    debugPrint(title.toString());
  }
}
