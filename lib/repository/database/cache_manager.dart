import 'package:flutter/material.dart';
import 'package:todo/models/group_model.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/repository/database/base_database.dart';
import 'package:todo/repository/get_id.dart';

class CacheManager extends BaseDatabase {
  List<Group> groupList = [
    Group(
        title: 'Test',
        tasks: [Task(title: 'Fap fap', isCompleted: false), Task(title: 'Wash hand', isCompleted: false)],
        id: GetId().genIDByDatetimeNow()),
  ];

  @override
  void addGroup(String title, String id) {
    Group newList = Group(title: title, tasks: [], id: id);
    groupList.add(newList);
    debugPrint(groupList.toString());
  }

  @override
  void addTask({required String groupName, required String titleTask}) {}

  @override
  List<Group> getGroupList() {
    return groupList;
  }

// get length of a tasks in group
  @override
  List<Task> getTaskList(String groupName) {
    Group relevantGroup = getRelevantGroup(groupName);
    return relevantGroup.tasks;
  }

  // return relevant object
  Group getRelevantGroup(String groupName) {
    Group relevantGroup = groupList.firstWhere((group) => group.title == groupName);

    return relevantGroup;
  }
}
