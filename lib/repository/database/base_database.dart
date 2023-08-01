import 'package:todo/models/group.dart';
import 'package:todo/models/task.dart';

abstract class BaseDatabase {

  List<Group> getGroupList();

  List<Task> getTaskList(String groupId);

  void addGroup(String title);

  void addTask(Task task);

  void removeGroup(String id);

  void removeTask(String taskId);

  void toggleMark(String taskId);

  void renameGroup(String id, String newName);

  void addTaskDescription(String taskId, String description);

  void toggleImportant(String taskId);

  void addDate(String taskId, DateTime date);

}
