import 'package:todo/models/task_model.dart';
import 'package:todo/models/group_model.dart';
import 'package:flutter/material.dart';

class ListManagement {
  static int groupIndex = 2;
  List<Group> groupList = [Group( title: 'My Day', tasks: []), Group( title: 'Important', tasks: [])];

  // get the list of groups
  List<Group> getGroupList() {
    return groupList;
  }

  // add a group
  Future<void> addGroup(String title) async {
    Group newList = Group( title: title, tasks: []);
    groupList.add(newList);
    print('HELLO$groupList');

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

// String genIDByDatetimeNow() {
//     return DateFormat('yyyyMMddHHmmss').format(DateTime.now());
//   }
  @override
  String toString() {
    return 'ListManagement{groupList: $groupList}';
  }
}
