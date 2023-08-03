import 'package:flutter/material.dart';
import 'package:todo/models/group.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/database/base_database.dart';
import 'package:todo/repository/get_id.dart';

class CacheManager extends BaseDatabase {
  // List with groups
  List<Group> groupList = [
    Group(id: 'Test', groupName: 'Test'),
  ];

  // List with tasks
  List<Task> tasks = [
    Task(id: '1', title: 'Read Holly Bible', isCompleted: false, groupId: 'Test', createdDate: DateTime.now()),
    Task(id: '2', title: 'Call Verka', isCompleted: false, groupId: 'Test', createdDate: DateTime.now()),
    Task(id: '3', title: 'See Pornhub', isCompleted: false, groupId: 'Test', createdDate: DateTime.now()),
  ];

  @override
  void addGroup(String title) {
    groupList.add(
      Group(id: GetId().genIDByDatetimeNow(), groupName: title),
    );
    debugPrint(groupList.toString());
  }

  @override
  void addTask(Task task) {
    tasks.add(task);
  }

  @override
  List<Group> getGroupList() {
    return groupList;
  }

// get length of a tasks in group
  @override
  List<Task> getTaskList(String groupId) {
    return tasks.where((element) => element.groupId == groupId).toList();
  }

  @override
  void removeGroup(String id) {
    groupList.removeWhere((element) => element.id == id);
  }

  @override
  void renameGroup(String id, String newName) {
    Group relevantGroup = groupList.firstWhere((element) => element.id == id);
    relevantGroup.groupName = newName;
  }

  @override
  void toggleMark(String taskId) {
    Task relevantTask = findRelevantTask(taskId);
    relevantTask.isCompleted = !relevantTask.isCompleted;
    debugPrint('Toggle Mark${relevantTask.isCompleted}');
  }

  @override
  void removeTask(String taskId) {
    tasks.removeWhere((element) => element.id == taskId);
  }

  @override
  void addTaskDescription(String taskId, String description) {
    Task relevantTask = findRelevantTask(taskId);
    relevantTask.description = description;
  }

  @override
  void toggleImportant(String taskId) {
    Task relevantTask = findRelevantTask(taskId);
    relevantTask.isImportant = !relevantTask.isImportant;
    debugPrint('Important Mark: ${relevantTask.isImportant}');

  }

  @override
  void addDate(String taskId, DateTime? date) {
    Task relevantTask = findRelevantTask(taskId);
    relevantTask.dueDate = date;
  }

  Task findRelevantTask(String taskId) {
    Task relevantTask = tasks.firstWhere((element) => element.id == taskId);
    return relevantTask;
  }
}
