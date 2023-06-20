import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/group_bloc/group_bloc.dart';
import 'package:todo/bloc/task_bloc/task_bloc.dart';
import 'package:todo/components/task_tile.dart';
import 'package:todo/repository/database/cache_manager.dart';
import 'package:todo/repository/get_id.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (BuildContext context) {
        TaskBloc bloc = TaskBloc(toDoRepository);
        bloc.add(GetTaskListEvent(widget.id));

        return bloc;
      },
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is GetTaskList) {
            return _buildParentWidget(context, state, widget.groupBloc);
          } else {
            return _buildEmptyWidget(context);
          }
        },
      ),
    );
  }

  _buildParentWidget(BuildContext context, GetTaskList state, GroupBloc groupBloc) {
    return Scaffold(
      backgroundColor: ColorSelect.lightPurpleBackground,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.drive_file_rename_outline),
          ),
          IconButton(
            onPressed: () {
              groupBloc.add(RemoveGroup(widget.id));
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.delete_outline),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ColorSelect.lightPurpleBackground,
        title: Text(
          widget.groupName,
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
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(index.toString()),
                      background: deleteBackground(),
                      onDismissed: (direction) {
                        BlocProvider.of<TaskBloc>(context)
                            .add(RemoveTask(widget.id, state.taskList[index].id));
                      },
                      child: TaskTile(
                        title: state.taskList[index].title,
                        taskCompleted: false,
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
          widget.groupName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: bottomButton(
        context,
      ),
    );
  }

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
                onChanged: (value) {
                  value = value;
                },
                controller: titleController,
                decoration: InputDecoration(
                    icon: const Icon(Icons.check_box_outline_blank),
                    hintText: AppLocalizations.of(context2).addTask,
                    border: InputBorder.none),
                onSubmitted: (String value) {
                  if (value.isNotEmpty) {
                    debugPrint(value);

                    print(widget.id);
                    BlocProvider.of<TaskBloc>(blocContext)
                        .add(AddTaskEvent(taskTitle: value, groupId: widget.id, taskId: GetId().genIDByDatetimeNow()));
                  } else {
                    debugPrint('Empty value');
                  }
                  Navigator.pop(blocContext);
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
}
