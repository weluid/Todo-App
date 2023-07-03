import 'package:todo/models/group_model.dart';
import 'package:todo/models/task_model.dart';

abstract class BaseDatabase {
  // get group list
  List<Group> getGroupList();

  // get task list
  List<Task> getTaskList(String groupName);

  // add group
  void addGroup(String title, String id);

  // add task to group
  void addTask({required String groupName, required String titleTask});
/**
 * remove group remove Task edit, important
 */
}
