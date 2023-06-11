import 'package:todo/models/group_model.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/repository/database/base_database.dart';

class AnyDB extends BaseDatabase {
  List<Group> groupList = [];

  @override
  void addGroup(String title) {
    Group newList = Group(title: title, tasks: []);
    groupList.add(newList);
    print('HELLO$groupList');
  }

  @override
  void addTask({required String groupName, required String titleTask}) {
    // find cur group
    Group relevantGroup = groupList.firstWhere((group) => group.title == groupName);
    //create new task
    Task newTask = Task(title: titleTask);
    //add task to cur group
    relevantGroup.tasks.add(newTask);
  }

  @override
  List<Group> getGroupList() {
    return groupList;
  }
  }
