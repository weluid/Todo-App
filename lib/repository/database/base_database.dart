import 'package:todo/models/group_model.dart';
import 'package:todo/models/task_model.dart';

abstract class BaseDatabase {
  // get group list
  List<Group> getGroupList();

  // get task list
  List<Task> getTaskList(String groupId);

  // add group
  void addGroup(String title, String id);

  // add task to group
  void addTask({required String titleTask, required String groupId, required String taskId});

  // remove group
  void removeGroup(String id);

  // remove task
  void removeTask(String groupID, String taskId);

  // mark task completed
  void markCompleted(String groupID, String taskId);
}
