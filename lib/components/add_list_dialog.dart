import 'package:flutter/material.dart';
import 'package:todo/utilities/constants.dart';
import 'package:todo/repository/task_list.dart';

class ListDialog extends StatefulWidget {
  const ListDialog({super.key});

  @override
  State<ListDialog> createState() => _ListDialogState();
}

class _ListDialogState extends State<ListDialog> {
  String? valueText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New List'),
      content: TextFormField(
        initialValue: 'Untitled List',
        onChanged: (value) {
          setState(() {
            valueText = value;
          });
        },
        decoration: const InputDecoration(hintText: "Enter list title"),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: Text(
                'Cancel',
                style: TextStyle(color: ColorSelect.primaryColor),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                if (valueText != null) {
                  TaskList.taskList.add(valueText);
                  debugPrint(TaskList.taskList.toString());
                  Navigator.of(context).pop();
                } else {
                  TaskList.taskList.add(valueText);
                  debugPrint(TaskList.taskList.toString());
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                width: 108,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: ColorSelect.primaryColor,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Create ',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
