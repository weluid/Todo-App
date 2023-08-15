import 'package:flutter/material.dart';
import 'package:todo/models/group.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/database/base_database.dart';
import 'package:todo/repository/get_id.dart';

class CacheManager extends BaseDatabase {
  // List with groups
  List<Group> groupList = [
    Group(id: 1, groupName: 'Test'),
  ];

  // List with tasks
  List<Task> tasks = [
    Task(id: 1, title: 'Read Holly Bible', isCompleted: false, groupId: 1, createdDate: DateTime.now()),
    Task(id: 2, title: 'Call Verka', isCompleted: false, groupId: 1, createdDate: DateTime.now()),
    Task(id: 3, title: 'See Pornhub', isCompleted: false, groupId: 1, createdDate: DateTime.now()),
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
  Future<List<Group>> getGroupList() async{
    return  groupList;
  }

// get length of a tasks in group
  @override
  Future<List<Task>> getTaskList(int groupId) async {
    return tasks.where((element) => element.groupId == groupId).toList();
  }

  @override
  void removeGroup(int id) {
    groupList.removeWhere((element) => element.id == id);
  }

  @override
  void renameGroup(int id, String newName) {
    Group relevantGroup = groupList.firstWhere((element) => element.id == id);
    relevantGroup.groupName = newName;
  }

  @override
  void toggleMark(int taskId) {
    Task relevantTask = findRelevantTask(taskId);
    relevantTask.isCompleted = !relevantTask.isCompleted;
    debugPrint('Toggle Mark${relevantTask.isCompleted}');
  }

  @override
  void removeTask(int taskId) {
    tasks.removeWhere((element) => element.id == taskId);
  }

  @override
  void addTaskDescription(int taskId, String description) {
    Task relevantTask = findRelevantTask(taskId);
    relevantTask.description = description;
  }

  @override
  void toggleImportant(int taskId) {
    Task relevantTask = findRelevantTask(taskId);
    relevantTask.isImportant = !relevantTask.isImportant;
    debugPrint('Important Mark: ${relevantTask.isImportant}');

  }

  @override
  void addDate(int taskId, DateTime? date) {
    Task relevantTask = findRelevantTask(taskId);
    relevantTask.dueDate = date;
  }

  Task findRelevantTask(int taskId) {
    Task relevantTask = tasks.firstWhere((element) => element.id == taskId);
    return relevantTask;
  }

  @override
  List<Task> importantSampling() {
    return tasks.where((task) => task.isImportant).toList();

  }
}
