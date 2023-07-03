import 'package:flutter/material.dart';
import 'package:todo/utilities/constants.dart';

class TaskTile extends StatefulWidget {
  final String title;
  final bool taskCompleted;

  const TaskTile({super.key, required this.title, required this.taskCompleted});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Checkbox(value: widget.taskCompleted, onChanged: null),
            const SizedBox(width: 24),
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.star_border,
                color: ColorSelect.grayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
