import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/components/delete_dialog.dart';
import 'package:todo/components/due_date_dialog.dart';
import 'package:todo/components/widgets.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/screens/splash_screen.dart';
import 'package:todo/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/task_extended_bloc/task_extended_bloc.dart';

class TaskInfoScreen extends StatefulWidget {
  final Task task;
  final String groupName;
  final String groupId;

  const TaskInfoScreen({super.key, required this.task, required this.groupName, required this.groupId});

  @override
  State<TaskInfoScreen> createState() => _TaskInfoScreenState();
}

class _TaskInfoScreenState extends State<TaskInfoScreen> {
  late bool _isCompleted = widget.task.isCompleted; // checkbox flag
  late bool _isImportant = widget.task.isImportant; // important flag
  late bool _isDateActive = widget.task.dueDate == null ? false : true; // date market flag
  late DateTime? dateTime = widget.task.dueDate;

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    if (widget.task.description.isNotEmpty) {
      _controller.text = widget.task.description;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      debugPrint('Focused');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskExtendedBloc>(
      create: (BuildContext context) {
        TaskExtendedBloc taskExtendedBloc = TaskExtendedBloc(context.read<ToDoRepository>());
        taskExtendedBloc.add(GetTaskListEvent(widget.groupId));

        return taskExtendedBloc;
      },
      child: BlocBuilder<TaskExtendedBloc, TaskExtendedState>(
        builder: (context, state) {
          if (state is GetTaskList) {
            return _buildParentWidget(context, state);
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }

  _buildParentWidget(BuildContext context, GetTaskList state) {
    return Scaffold(
      bottomNavigationBar: bottomAppBar(context),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: Text(widget.groupName),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _isCompleted,
                      onChanged: (bool? value) {
                        BlocProvider.of<TaskExtendedBloc>(context).add(ToggleMarkEvent(widget.task.id));
                        setState(() {
                          _isCompleted = !_isCompleted;
                        });
                      },
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        widget.task.title,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isImportant = !_isImportant;
                        });

                        BlocProvider.of<TaskExtendedBloc>(context).add(ToggleImportantEvent(widget.task.id));
                      },
                      child: _isImportant ? activeImportantIcon : disabledImportantIcon,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Divider(
                    color: ColorSelect.lightGrayColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return DueDate(
                          datePicker: () => _showDatePicker(context),
                          dateToday: () {
                            Navigator.pop(context);
                            // current day date
                            DateTime now = DateTime.now();
                            dateTime = DateTime(now.year, now.month, now.day, 0, 0);
                            BlocProvider.of<TaskExtendedBloc>(context).add(AddDateEvent(widget.task.id, dateTime));

                            setState(() {
                              _isDateActive = true;
                            });

                            debugPrint(dateTime.toString());
                          },
                          dateTomorrow: () {
                            Navigator.pop(context);
                            // next day date
                            DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
                            dateTime = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 0, 0);

                            BlocProvider.of<TaskExtendedBloc>(context).add(AddDateEvent(widget.task.id, dateTime));

                            setState(() {
                              _isDateActive = true;
                            });

                            debugPrint(dateTime.toString());
                          },
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.event,
                        color: ColorSelect.grayColor,
                      ),
                      const SizedBox(width: 18),
                      Text(
                        _isDateActive
                            ? '${AppLocalizations.of(context).due}: ${DateFormat('E, d MMMM').format(dateTime!)}'
                            : AppLocalizations.of(context).dueData,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 16,
                          color: _isDateActive ? ColorSelect.primaryColor : ColorSelect.grayColor,
                        ),
                      ),
                      const Spacer(),
                      if (_isDateActive)
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<TaskExtendedBloc>(context).add(AddDateEvent(widget.task.id, null));

                            setState(() {
                              _isDateActive = false;
                            });
                          },
                          child: Icon(Icons.close, color: ColorSelect.grayColor),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 210,
                  child: Column(
                    children: [
                      if (_focusNode.hasFocus)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context).note,
                            style: TextStyle(fontSize: 12, color: ColorSelect.primaryColor),
                          ),
                        ),
                      TextFormField(
                        focusNode: _focusNode,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (String value) {
                          if (value.trim().isNotEmpty) {
                            debugPrint(value);
                            BlocProvider.of<TaskExtendedBloc>(context)
                                .add(AddDescriptionEvent(taskId: widget.task.id, description: value));
                          }
                        },
                        controller: _controller,
                        maxLines: 7,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context).addNote,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: _focusNode.hasFocus ? ColorSelect.primaryColor : ColorSelect.lightGrayColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomAppBar bottomAppBar(BuildContext context) {
    return BottomAppBar(
      height: 50,
      elevation: 0,
      child: Column(
        children: [
          // const Spacer(),
          Row(
            children: [
              Expanded(
                child: Text(
                  DateTime.now().isAfter(widget.task.createdDate)
                      ? AppLocalizations.of(context).createdToday
                      : '${AppLocalizations.of(context).createdOn} ${DateFormat('E, d MMMM').format(widget.task.createdDate)}',
                  // 'Created on Mon, 20 April',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  bool? isDeleted = await showDialog(
                    context: context,
                    builder: (dialogContext) => DeletedDialog(
                      deleteObject: (taskId) {
                        BlocProvider.of<TaskExtendedBloc>(context)
                            .add(RemoveTaskEvent(groupId: widget.groupId, taskId: widget.task.id));
                      },
                      id: widget.task.id,
                      desc: AppLocalizations.of(context).taskDelete,
                    ),
                  );

                  if (isDeleted != null) {
                    if (!mounted) return;
                    Navigator.pop(context, true);
                  }
                },
                child: Icon(Icons.delete_outline, color: ColorSelect.grayColor, size: 24),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    Navigator.pop(context);

    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2102),
    ).then((value) {
      if (value != null) {
        dateTime = value;
        BlocProvider.of<TaskExtendedBloc>(context).add(AddDateEvent(widget.task.id, dateTime));

        setState(() {
          _isDateActive = true;
        });
      }
      debugPrint(value.toString());
    });
  }
}
