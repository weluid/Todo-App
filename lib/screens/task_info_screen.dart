import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/components/delete_dialog.dart';
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
  late bool isCompleted = widget.task.isCompleted; // checkbox flag
  bool isImportant = false; // important flag
  bool isDateActive = false; // date market flag
  Color dateTextColor = ColorSelect.grayColor; // date text color

  final TextEditingController _controller = TextEditingController();
  bool _isTextFieldEmpty = true;


  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextFieldChange);
    if (widget.task.description.isNotEmpty) {
      _controller.text = widget.task.description;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextFieldChange);
    _controller.dispose();
    super.dispose();
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
          padding: const EdgeInsets.only(left: 15, right: 20, top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isCompleted,
                    onChanged: (bool? value) {
                      setState(() {
                        isCompleted = !isCompleted;
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
                    onTap: toggleImportantIconColor,
                    child: isImportant ? activeImportantIcon : disabledImportantIcon,
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
                onTap: toggleDateIconVisibility,
                child: Row(
                  children: [
                    Icon(
                      Icons.event,
                      color: ColorSelect.grayColor,
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context).dueData,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    // const Spacer(),
                    if (isDateActive)
                      GestureDetector(
                        onTap: () {
                          debugPrint('deleted date');
                          toggleDateIconVisibility();
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
                    if (!_isTextFieldEmpty)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context).note,
                          style: TextStyle(fontSize: 12, color: ColorSelect.primaryColor),
                        ),
                      ),
                    TextFormField(

                        textInputAction: TextInputAction.done,
                      onFieldSubmitted: (String value) {
                        if (value.trim().isNotEmpty) {
                          debugPrint(value);
                          BlocProvider.of<TaskExtendedBloc>(context)
                              .add(AddDescription(taskId: widget.task.id, description: value));
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
                color: _isTextFieldEmpty ? ColorSelect.lightGrayColor : ColorSelect.primaryColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Created on Mon, 20 April',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            bool isDeleted = await showDialog(
                              context: context,
                              builder: (dialogContext) => DeletedDialog(
                                deleteObject: (taskId) {
                                  BlocProvider.of<TaskExtendedBloc>(context)
                                      .add(RemoveTask(groupId: widget.groupId, taskId: widget.task.id));
                                },
                                id: widget.task.id,
                                desc: AppLocalizations.of(context).taskDelete,
                              ),
                            );

                            if (isDeleted) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  // If a deadline is set - show deleted button
  void toggleDateIconVisibility() {
    setState(() {
      isDateActive = !isDateActive;
    });
  }

  void toggleImportantIconColor() {
    setState(() {
      isImportant = !isImportant;
    });
  }

  // Check if a text field is empty
  void _onTextFieldChange() {
    setState(() {
      _isTextFieldEmpty = _controller.text.isEmpty;
    });
  }
}
