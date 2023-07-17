import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/utilities/constants.dart';

typedef IdCallback = void Function(String id);

class TaskTile extends StatefulWidget {
  final IdCallback onTap;
  final Task task;

  const TaskTile({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Checkbox(
            value: isCompleted,
            onChanged: (bool? value) {
              widget.onTap.call(widget.task.id);

              setState(() {
                isCompleted = !isCompleted;
              });
            },
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Text(
              widget.task.title,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const Spacer(),
          GestureDetector(
            child: Icon(Icons.star_border, color: ColorSelect.grayColor),
          )
        ],
      ),
    );
  }
}
