import 'package:todo/models/group_model.dart';
import 'package:todo/repository/database/base_database.dart';

class AnyDB extends BaseDatabase {
  @override
  void addGroup(String title) {
    // TODO: implement addGroup
  }

  @override
  void addTask({required String groupName, required String titleTask}) {
    // TODO: implement addTask
  }

  @override
  List<Group> getGroupList() {
    // TODO: implement getGroupList
    throw UnimplementedError();
  }
 
  }
