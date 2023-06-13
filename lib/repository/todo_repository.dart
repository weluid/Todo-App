import 'package:flutter/material.dart';

import 'package:todo/models/group_model.dart';
import 'package:todo/repository/database/base_database.dart';


class ToDoRepository {

  final BaseDatabase _localDb;

  ToDoRepository(this._localDb);

  // get the list of groups
  List<Group> getGroupList() {
    return _localDb.getGroupList();
  }

  // add a group
  void addGroup(String title, String id) {
    _localDb.addGroup(title, id);
    debugPrint(title.toString());
  }

}
