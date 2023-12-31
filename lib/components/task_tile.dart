import 'package:flutter/material.dart';
import 'package:todo/components/widgets.dart';
import 'package:todo/models/task.dart';

typedef IdCallback = void Function(int id);

class TaskTile extends StatefulWidget {
  final IdCallback onCheckboxChanged;
  final IdCallback onImportantChanged;
  final VoidCallback onInfoScreen;
  final Task task;

  const TaskTile({
    super.key,
    required this.task,
    required this.onCheckboxChanged,
    required this.onInfoScreen,
    required this.onImportantChanged,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late bool isImportant = widget.task.isImportant; // important flag
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Checkbox(
            activeColor: Theme.of(context).colorScheme.outlineVariant,
            value: widget.task.isCompleted,
            onChanged: (bool? value) {
              setState(() {
                widget.task.isCompleted = !value!;
              });

              widget.onCheckboxChanged.call(widget.task.id);
            },
          ),
          const SizedBox(width: 24),
          Expanded(
            child: GestureDetector(
              onTap: widget.onInfoScreen,
              child: Text(
                widget.task.title,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (widget.task.groupId == 2) {
                  return;
                } else {
                  isImportant = !isImportant;
                }
              });

              widget.onImportantChanged.call(widget.task.id);
            },
            child: isImportant ? activeImportantIcon : disabledImportantIcon,
          )
        ],
      ),
    );
  }
}
