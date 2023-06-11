import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/group_model.dart';
import 'package:todo/repository/get_id.dart';

class TodoRepository {
  final List<Group> groupList = [
    Group(title: 'My Day', tasks: [], id: GetId().genIDByDatetimeNow()),
    Group(title: 'Important', tasks: [], id: GetId().genIDByDatetimeNow())
  ];

  // get the list of groups
  List<Group> getGroupList() {
    return groupList;
  }

  // add a group
  void addGroup(String title, String id) {
    Group newList = Group(title: title, tasks: [], id: id);
    groupList.add(newList);
    debugPrint(groupList.toString());
  }

  //add a task to group
  void addTask({required String groupName, required String titleTask}) {
    // find cur group
    Group relevantGroup = groupList.firstWhere((group) => group.title == groupName);
    //create new task
    Task newTask = Task(title: titleTask);
    //add task to cur group
    relevantGroup.tasks.add(newTask);
  }

  @override
  String toString() {
    return 'ListManagement{groupList: $groupList}';
  }
}
