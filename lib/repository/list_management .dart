import 'package:todo/models/task_model.dart';
import 'package:todo/models/group_model.dart';
import 'package:flutter/material.dart';

class ListManagement {
  static int groupIndex = 2;
  List<Group> groupList = [
    Group(index: 0, title: 'My Day', tasks: []),
    Group(index: 1, title: 'Important', tasks: [])
  ];

  // get the list of groups
  List<Group> getGroupList (){
    return groupList;
  }

  // add a group
  void addGroup(String title, int index) {
    Group newList = Group(index: index, title: title, tasks: []);
    groupList.add(newList);
    // debugPrint(index.toString());
  }

  //add a task to group
  void addTask(int id, String titleTask) {
    Task newTask = Task(title: titleTask);
    groupList[id].tasks.add(newTask);
  }

  @override
  String toString() {
    return 'ListManagement{groupList: $groupList}';
  }
}
