import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/bloc/group_bloc/group_bloc.dart';
import 'package:todo/bloc/task_bloc/task_bloc.dart';
import 'package:todo/components/task_tile.dart';
import 'package:todo/repository/database/cache_manager.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskScreen extends StatefulWidget {
  final String groupName;
  final GroupBloc groupBloc;
  final String id;

  const TaskScreen({required this.groupName, required this.groupBloc, required this.id, super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  ToDoRepository toDoRepository = ToDoRepository.getInstance(CacheManager());
  late TaskBloc taskBloc;
  late GroupBloc groupBloc = widget.groupBloc;
  late String groupNameTitle = widget.groupName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (BuildContext context) {
        taskBloc = TaskBloc(toDoRepository);
        taskBloc.add(GetTaskListEvent(widget.id));

        return taskBloc;
      },
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is GetTaskList) {
            return _buildParentWidget(context, state, groupBloc, taskBloc);
          } else {
            return _buildEmptyWidget(context);
          }
        },
      ),
    );
  }

  _buildParentWidget(BuildContext context, GetTaskList state, GroupBloc groupBloc, TaskBloc taskBloc) {
    return Scaffold(
      backgroundColor: ColorSelect.lightPurpleBackground,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _showRenameDialog(context);
            },
            icon: const Icon(Icons.drive_file_rename_outline),
          ),
          IconButton(
            onPressed: () {
              _showDeleteDialog(context);
            },
            icon: const Icon(Icons.delete_outline),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ColorSelect.lightPurpleBackground,
        title: Text(
          groupNameTitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: ListView.builder(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.taskList.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      direction: Axis.horizontal,
                      key: Key(state.taskList[index].toString()),
                      endActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: const ScrollMotion(),
                        children: [
                          const SizedBox(width: 10),
                          deletionCard(context, state, index),
                        ],
                      ),
                      child: TaskTile(
                        task: state.taskList[index],
                        onTap: (id) {
                          BlocProvider.of<TaskBloc>(context).add(
                            ToggleMark(id),
                          );
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomButton(context),
    );
  }

  // deletion card by left swipe
  Expanded deletionCard(BuildContext context, GetTaskList state, int index) {
    return Expanded(
      flex: 1,
      child: Card(
        margin: const EdgeInsets.only(bottom: 4, top: 4),
        elevation: 0,
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: ColorSelect.importantColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            width: double.infinity,
            child: const Center(
                child: Icon(
              Icons.delete_outline,
              color: Colors.white,
            )),
          ),
          onTap: () => BlocProvider.of<TaskBloc>(context).add(
            RemoveTask(widget.id, state.taskList[index].id),
          ),
        ),
      ),
    );
  }

  _buildEmptyWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.lightPurpleBackground,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.drive_file_rename_outline),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ColorSelect.lightPurpleBackground,
        title: Text(
          groupNameTitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: bottomButton(
        context,
      ),
    );
  }

  // bottom button for add task
  Padding bottomButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () => _addTask(context),
        child: Container(
          padding: const EdgeInsets.only(left: 17, bottom: 12, top: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: ColorSelect.darkPurple),
          child: Row(
            children: [
              const Icon(
                Icons.add,
                color: Colors.white,
              ),
              const SizedBox(width: 9),
              Text(
                AppLocalizations.of(context).addTask,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  // field for adding task
  _addTask(BuildContext blocContext) {
    TextEditingController titleController = TextEditingController();

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      context: blocContext,
      builder: (context2) => Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 50,
          child: Column(
            children: [
              TextField(
                autofocus: true,
                controller: titleController,
                decoration: InputDecoration(
                    icon: const Icon(Icons.check_box_outline_blank),
                    hintText: AppLocalizations.of(context).addTask,
                    border: InputBorder.none),
                onSubmitted: (String value) {
                  if (value.isNotEmpty) {
                    debugPrint(value);
                    BlocProvider.of<TaskBloc>(blocContext).add(AddTaskEvent(taskTitle: value, groupId: widget.id));
                    Navigator.pop(blocContext);
                  } else {
                    debugPrint('Empty value');
                    Navigator.pop(blocContext);
                  }
                },
              ),
              Divider(
                height: 2,
                color: ColorSelect.grayColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Delete group pop-up
  _showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Are you sure?',
              style: TextStyle(fontSize: 22),
            ),
            content: const Text('Group will be permanently deleted'),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: ColorSelect.primaryColor, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: (){
                  groupBloc.add(RemoveGroup(widget.id));
                  Navigator.pop(context, true);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Container(
                  height: 40,
                  width: 89,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorSelect.importantColor,
                  ),
                  child: const Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  // Rename group pop-up
  _showRenameDialog(BuildContext context) {
    late String inputText;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Rename list',
              style: TextStyle(fontSize: 22),
            ),
            content: TextField(
              onChanged: (value) {
                inputText = value;
              },
              decoration: const InputDecoration(
                hintText: "Rename Group",
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: ColorSelect.primaryColor, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  if (inputText.isNotEmpty) {
                    groupBloc.add(RenameGroup(id: widget.id, newName: inputText.trim()));
                    setState(() {
                      groupNameTitle = inputText.trim();
                    });
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 40,
                  width: 89,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorSelect.primaryColor,
                  ),
                  child: const Center(
                    child: Text(
                      'Rename',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
