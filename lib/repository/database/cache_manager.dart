import 'package:flutter/material.dart';
import 'package:todo/models/group_model.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/repository/database/base_database.dart';
import 'package:todo/repository/get_id.dart';

class CacheManager extends BaseDatabase {
  List<Group> groupList = [
    Group(
        title: 'Test',
        tasks: [
          Task(title: 'Fap fap', isCompleted: false, id: GetId().genIDByDatetimeNow()),
          Task(title: 'Wash hand', isCompleted: false, id: GetId().genIDByDatetimeNow())
        ],
        id: GetId().genIDByDatetimeNow()),
  ];

  @override
  void addGroup(String title, String id) {
    Group newList = Group(title: title, tasks: [], id: id);
    groupList.add(newList);
    debugPrint(groupList.toString());
  }

  @override
  void addTask({required String titleTask, required String groupId, required String taskId}) {
    Group relevantGroup = getRelevantGroup(groupId);

    relevantGroup.tasks.add(Task(title: titleTask, isCompleted: false, id: taskId));
  }

  @override
  List<Group> getGroupList() {
    return groupList;
  }

// get length of a tasks in group
  @override
  List<Task> getTaskList(String groupId) {
    Group relevantGroup = getRelevantGroup(groupId);
    return relevantGroup.tasks;
  }

  @override
  void removeGroup(String id) {
    Group relevantGroup = getRelevantGroup(id);
    groupList.remove(relevantGroup);
  }

  @override
  void markCompleted(String groupID, String taskId) {
    Group relevantGroup = getRelevantGroup(groupID);

    Task relevantTask = getRelevantTask(taskId, relevantGroup);
    relevantTask.isCompleted = !relevantTask.isCompleted;
  }

  @override
  void removeTask(String groupID, String taskId) {
    Group relevantGroup = getRelevantGroup(groupID);
    Task relevantTask = getRelevantTask(taskId, relevantGroup);

    relevantGroup.tasks.remove(relevantTask);
    debugPrint(relevantGroup.toString());

  }

  // return relevant group
  Group getRelevantGroup(String id) {
    Group relevantGroup = groupList.singleWhere((group) => group.id == id);

    return relevantGroup;
  }

  // return relevant group
  Task getRelevantTask(String taskId, Group relevantGroup) {
    Task relevantTask = relevantGroup.tasks.firstWhere((task) => task.id == taskId);

    return relevantTask;
  }
}
