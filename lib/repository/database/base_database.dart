import 'package:todo/models/group.dart';
import 'package:todo/models/task.dart';

abstract class BaseDatabase {
  // get group list
  List<Group> getGroupList();

  // get task list
  List<Task> getTaskList(String groupId);

  // add group
  void addGroup(String title);

  // add task to group
  void addTask(Task task);

  // remove group
  void removeGroup(String id);

  // remove task
  void removeTask(String taskId);

  // mark task completed
  void toggleMark(String taskID);

  // rename group
  void renameGroup(String id, String newName);
}
