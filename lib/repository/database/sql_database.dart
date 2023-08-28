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
  void addDate(int taskId, DateTime? date) async {
    final db = await database;

    await db.rawUpdate('''
    UPDATE Task
    SET dueDate = ?
    WHERE id = ?
    ''', [date?.toIso8601String(), taskId]);
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
  void addTaskDescription(int taskId, String description) async {
    final db = await database;

    await db.rawUpdate('''
    UPDATE Task
    SET description = ?
    WHERE id = ? ''', [description, taskId]);
  }

  @override
  Future<List<Group>> getGroupList() async {
    final db = await database;

    final List<Map<String, dynamic>> groups = await db.query('Group');
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
    await db.rawDelete('''DELETE FROM Task WHERE groupId = ?''', [id]);
  }

  @override
  void removeTask(int taskId) async {
    final db = await database;

    await db.delete('Task', where: 'id = ?', whereArgs: [taskId]);
  }

  @override
  void renameGroup(int id, String newName) async {
    final db = await database;

    await db.update(
      'Group',
      {'groupName': newName},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  void toggleImportant(int taskId) async {
    final db = await database;

    await db.rawUpdate('''
    UPDATE Task
    SET isImportant = CASE
    WHEN isImportant = 1 THEN 0
    ELSE 1
    END
    WHERE id = ?
    ''', [taskId]);
  }

  @override
  void toggleMark(int taskId) async {
    final db = await database;

    await db.rawUpdate('''
    UPDATE Task
    SET isCompleted = CASE
    WHEN isCompleted = 1 THEN 0
    ELSE 1
    END
    WHERE id = ?
    ''', [taskId]);
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

    // Insert initial groups
    await db.insert('Group', {'groupName': 'My Day'});
    await db.insert('Group', {'groupName': 'Important'});
  }

  @override
  Future<List<Task>> importantSampling() async {
    final db = await database;

    final List<Map<String, dynamic>> tasks = await db.query(
      'Task',
      where: 'isImportant = ?',
      whereArgs: [1],
    );

    return tasks.map((map) => Task.fromJson(map)).toList();
  }
}
