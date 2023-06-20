import 'package:todo/models/group_model.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/repository/database/base_database.dart';

class AnyDB extends BaseDatabase {
  @override
  void addGroup(String title, String id) {
    // TODO: implement addGroup
  }

  @override
  void addTask({ required String titleTask, required String groupId, required String taskId}) {
    // TODO: implement addTask
  }

  @override
  List<Group> getGroupList() {
    // TODO: implement getGroupList
    throw UnimplementedError();
  }

  @override
  List<Task> getTaskList( String groupId) {
    // TODO: implement getTaskList
    throw UnimplementedError();
  }

  @override
  void removeGroup(String id) {
    // TODO: implement removeGroup
  }

  @override
  void markCompleted(String groupID, String taskId) {
    // TODO: implement markCompleted
  }

  @override
  void removeTask(String groupID, String taskId) {
    // TODO: implement removeTask
  }
 
  }
