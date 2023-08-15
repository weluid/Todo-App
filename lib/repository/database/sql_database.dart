import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:todo/models/group.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/database/base_database.dart';
import 'package:path/path.dart';

class SqlDatabase extends BaseDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initialize();
    return _database!;
  }

  @override
  void addDate(int taskId, DateTime? date) {
    // TODO: implement addDate
  }

  @override
  Future<void> addGroup(String title) async {
    final db = await database;
    final groupMap = {'groupName': title};
    await db.insert('Group', groupMap, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  void addTask(Task task) async {
    final db = await database;
    await db.insert(
      'Task',
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  void addTaskDescription(int taskId, String description) {
    // TODO: implement addTaskDescription
  }

  @override
  Future<List<Group>> getGroupList() async {
    final db = await database;

    final List<Map<String, dynamic>> groups = await db.query('Group');
    print("aaaaaaa$groups");

    return groups.map((map) => Group.fromJson(map)).toList();
  }

  @override
  Future<List<Task>> getTaskList(int groupId) async {
    final db = await database;

    final List<Map<String, dynamic>> tasks = await db.query(
      'Task',
      where: 'groupId = ?',
      whereArgs: [groupId],
    );

    return tasks.map((map) => Task.fromJson(map)).toList();
  }

  @override
  void removeGroup(int id) async {
    final db = await database;
    await db.delete('Group', where: 'id = ?', whereArgs: [id]);
  }

  @override
  void removeTask(int taskId) async {
    final db = await database;
    await db.delete('Task', where: 'id = ?', whereArgs: [taskId]);
  }

  @override
  void renameGroup(int id, String newName) {
    // TODO: implement renameGroup
  }

  @override
  void toggleImportant(int taskId) {
    // TODO: implement toggleImportant
  }

  @override
  void toggleMark(int taskId) {
    // TODO: implement toggleMark
  }

  Future<String> get fullPath async {
    const name = 'todo.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path, version: 1, onCreate: _createDB, singleInstance: true);
    return database;
  }

  FutureOr<void> _createDB(Database db, int version) async {
    // Group table
    await db.execute('''
    CREATE TABLE "Group" (
     id INTEGER PRIMARY KEY,
    groupName TEXT
    )
    ''');

    // Task table
    await db.execute('''
    CREATE TABLE 'Task' (
      id INTEGER PRIMARY KEY,
      title TEXT,
      description TEXT,
      isImportant INTEGER,
      isCompleted INTEGER,
      groupId INTEGER,
      dueDate TEXT,
      createdDate TEXT,
      FOREIGN KEY (groupId) REFERENCES "Group" (id)
    )
  ''');

    await db.insert('Group', {'groupName': 'My Day'});
    await db.insert('Group', {'groupName': 'Important'});
  }

  Future close() async {
    final db = await database;

    db.close();
  }

  Future<Group> create(Group group) async {
    final db = await database;

    final id = await db.insert("group", group.toJson());
    return group.copy(id: id);
  }

  @override
  List<Task> importantSampling() {
    // TODO: implement importantSampling
    throw UnimplementedError();
  }
}
