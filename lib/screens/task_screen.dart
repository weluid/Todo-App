import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/bloc/task_bloc/task_bloc.dart';
import 'package:todo/components/delete_dialog.dart';
import 'package:todo/components/task_tile.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/screens/task_info_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/utilities/constants.dart';

class TaskScreen extends StatefulWidget {
  final String groupName;
  final int id;

  const TaskScreen({required this.groupName, required this.id, super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with SingleTickerProviderStateMixin {
  late String groupNameTitle = widget.groupName;

  late TabController _tabController;
  bool selectedTabMarker = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (BuildContext context) {
        TaskBloc taskBloc = TaskBloc(context.read<ToDoRepository>());
        taskBloc.add(GetUncompletedTasksEvent(widget.id));

        return taskBloc;
      },
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is GetTaskList) {
            return _buildParentWidget(context, state);
          } else {
            return _buildEmptyWidget(context);
          }
        },
      ),
    );
  }

  _buildParentWidget(BuildContext context, GetTaskList state) {
    // management click on TavVar
    void clickManagement(int index) {
      setState(() {
        if (index == 0) {
          BlocProvider.of<TaskBloc>(context).add(GetUncompletedTasksEvent(widget.id));
          selectedTabMarker = false;
        } else {
          BlocProvider.of<TaskBloc>(context).add(GetCompletedTaskEvent(widget.id));
          selectedTabMarker = true;
        }
      });
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          // leading - back to home page button
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          actions: widget.id == 1 || widget.id ==2 ? null :
          [
            IconButton(
              onPressed: () {
                _showRenameDialog(context);
              },
              icon: const Icon(Icons.drive_file_rename_outline),
            ),
            IconButton(
              onPressed: () async {
                bool? isDeleted = await showDialog(
                  context: context,
                  builder: (dialogContext) => DeletedDialog(
                    deleteObject: (groupId) {
                      BlocProvider.of<TaskBloc>(context).add(RemoveGroupEvent(widget.id));
                    },
                    id: widget.id,
                    desc: AppLocalizations.of(context).groupDelete,
                  ),
                );

                if (isDeleted !=null) {
                  if (!mounted) return;
                  Navigator.pop(context, true);
                }
              },
              icon: const Icon(Icons.delete_outline),
            )
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            groupNameTitle,
            style: const TextStyle(color: Colors.white),
          ),

          bottom: TabBar(
            controller: _tabController,
            onTap: clickManagement,
            indicatorSize: TabBarIndicatorSize.tab,
            splashFactory: NoSplash.splashFactory,
            indicatorColor: Theme.of(context).colorScheme.outlineVariant,
            labelColor: Theme.of(context).colorScheme.outlineVariant,
            tabs: [
              const Tab(text: 'To Do'),
              Tab(text: AppLocalizations.of(context).completed),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
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
                              onCheckboxChanged: (id) {
                                BlocProvider.of<TaskBloc>(context).add(ToggleMarkEvent(id));

                                Future.delayed(const Duration(milliseconds:500), () {
                                  selectedTabMarker == false
                                      ? BlocProvider.of<TaskBloc>(context).add(GetUncompletedTasksEvent(widget.id))
                                      : BlocProvider.of<TaskBloc>(context).add(GetCompletedTaskEvent(widget.id));
                                });
                              },
                              onInfoScreen: () async {
                                // flag for updating task list on page
                                bool changeFlag = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskInfoScreen(
                                      task: state.taskList[index],
                                      groupName: groupNameTitle,
                                      groupId: widget.id,
                                      selectedTab: selectedTabMarker,
                                    ),
                                  ),
                                );
                                if (changeFlag == false) {
                                  if (!mounted) return;
                                  BlocProvider.of<TaskBloc>(context).add(GetUncompletedTasksEvent(widget.id));
                                } else {
                                  if (!mounted) return;
                                  BlocProvider.of<TaskBloc>(context).add(GetCompletedTaskEvent(widget.id));
                                }
                              },
                              // important change
                              onImportantChanged: (id) {
                                BlocProvider.of<TaskBloc>(context).add(ToggleImportantEvent(state.taskList[index].id));
                                if (selectedTabMarker == false) {
                                  if (!mounted) return;
                                  BlocProvider.of<TaskBloc>(context).add(GetUncompletedTasksEvent(widget.id));
                                } else {
                                  if (!mounted) return;
                                  BlocProvider.of<TaskBloc>(context).add(GetCompletedTaskEvent(widget.id));
                                }
                              },
                            ),
                          );
                        }),
                  ],
                ),
              ),

        ),
        bottomNavigationBar: bottomButton(context),
      ),
    );
  }

  // deletion card by left swipe
  Expanded deletionCard(BuildContext context, state, int index) {
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
            RemoveTaskEvent(widget.id, state.taskList[index].id),
          ),
        ),
      ),
    );
  }

  _buildEmptyWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
        backgroundColor: Theme.of(context).colorScheme.background,
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
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
      child: GestureDetector(
        onTap: () => _addTask(context),
        child: Container(
          padding: const EdgeInsets.only(left: 17, bottom: 12, top: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Theme.of(context).colorScheme.secondaryContainer),
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
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      context: blocContext,
      builder: (context) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                controller: titleController,
                decoration: InputDecoration(
                    icon: const Icon(Icons.check_box_outline_blank),
                    hintText: AppLocalizations.of(context).addTask,
                    border: InputBorder.none),
                onSubmitted: (String value) {
                  if (value.trim().isNotEmpty) {
                    debugPrint(value);
                    BlocProvider.of<TaskBloc>(blocContext).add(AddTaskEvent(taskTitle: value, groupId: widget.id));
                    // fixing a bug with incorrect display of tasks
                    selectedTabMarker == false
                        ? BlocProvider.of<TaskBloc>(blocContext).add(GetUncompletedTasksEvent(widget.id))
                        : BlocProvider.of<TaskBloc>(blocContext).add(GetCompletedTaskEvent(widget.id));
                    Navigator.pop(blocContext);
                  } else {
                    debugPrint('Empty value');
                    Navigator.pop(blocContext);
                  }
                },
              ),
              Divider(
                height: 2,
                color: Theme.of(context).colorScheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Rename group pop-up
  _showRenameDialog(BuildContext blocContext) {
    String inputText = '';
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            surfaceTintColor: Theme.of(context).colorScheme.background,
            title: Text(
              AppLocalizations.of(context).renameGroup,
              style: const TextStyle(fontSize: 22),
            ),
            content: TextField(
              onChanged: (value) {
                inputText = value;
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).renameGroup,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context).cancel,
                  style: TextStyle(color: Theme.of(context).colorScheme.outlineVariant, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  if (inputText.trim().isNotEmpty) {
                    BlocProvider.of<TaskBloc>(blocContext)
                        .add(RenameGroupEvent(id: widget.id, newName: inputText.trim()));
                    setState(() {
                      groupNameTitle = inputText.trim();
                    });
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 40,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).rename,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
