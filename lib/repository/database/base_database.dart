
import 'package:todo/models/group_model.dart';

abstract class BaseDatabase{

  // get group list
  List<Group> getGroupList();
  // add group
  void addGroup(String title,String id);
  // add task
  void addTask({required String groupName, required String titleTask});
/**
 * remove group remove Task edit, important
 */
}