import 'package:todo/models/group.dart';
import 'package:todo/models/task.dart';

abstract class BaseDatabase {

  Future<List<Group>> getGroupList();

  Future<List<Task>>getTaskList(int groupId);

  void addGroup(String title);

  void addTask(Task task);

  void removeGroup(int id);

  void removeTask(int taskId);

  void toggleMark(int taskId);

  void renameGroup(int id, String newName);

  void addTaskDescription(int taskId, String description);

  void toggleImportant(int taskId);

  void addDate(int taskId, DateTime? date);

  }
