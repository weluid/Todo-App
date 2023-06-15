import 'package:flutter/material.dart';

import 'package:todo/models/group_model.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/repository/database/base_database.dart';

class ToDoRepository {
  final BaseDatabase _cacheManager;

  ToDoRepository(this._cacheManager);

  // get the list of groups
  List<Group> getGroupList() {
    return _cacheManager.getGroupList();
  }

// get the list of groups
  List<Task> getTaskList(String groupName) {
    return _cacheManager.getTaskList(groupName);
  }

  // add a group
  void addGroup(String title, String id) {
    _cacheManager.addGroup(title, id);
    debugPrint(title.toString());
  }
}
